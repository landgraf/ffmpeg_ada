with Ada.Strings.Fixed;
with Ada.Characters.Latin_1;
package body ffmpeg.Internal.frame.subtitle is 

    function Allocate return AVSubtitle_Access_T is
    begin
        return new AVSubtitle_T;
    end Allocate;

    procedure Deallocate (Self : in AVSubtitle_Access_T) is
        procedure C_Deallocate (Subtitle : AVSubtitle_Access_T)
            with Import, Convention => C, External_Name => "avsubtitle_free";
    begin
        C_Deallocate (Self);
    end Deallocate;


    function Decode (Subtitle : in AVSubtitle_Access_T; Codec : AVCodec_Context_Access_T; Packet : AVPacket_Access_T) return Integer is
      use type C.Int;
      Has_subtitle : aliased C.Int;
      function c_decode (avctx : AVCodec_Context_Access_T;
        sub   : AVSubtitle_Access_T;
        got_sub_ptr : access C.Int;
        avpkt : AVPacket_Access_T
        ) return C.Int with Import, Convention => C, External_Name => "avcodec_decode_subtitle2";
    begin
      if c_decode (Codec, Subtitle, Has_Subtitle'Access, Packet) >= 0 then
        return Integer(Has_Subtitle);
      end if;
      Return -1;
    end Decode;

    function Text (Subtitle : in AVSubtitle_Access_T; Rects : Natural := 1) return String is
      use AV_SubtitleRect_Pointers;
      use type Interfaces.Unsigned_32;
      Rect : AVSubtitleRect_Access_T;
      Retval : Unbounded_String := Null_Unbounded_String;
      function Get_Text_From_Ass (Text : String) return String is
        use Ada.Strings.Fixed;
        Start_From : Natural := Text'First;
      begin
        if Ada.Strings.Fixed.Count(Text, ",") < 4 then
          raise Constraint_Error with "Wrong ass format!";
        end if;
        for I in 1 .. 4 loop
          Start_From := Index(Text, ",", Start_From + 1);
        end loop;
        return Text (Start_From + 1 .. Text'Last);
      end Get_Text_From_Ass;
      First_Rect : AV_SubtitleRect_Pointers.Pointer;

    begin
        if subtitle.num_rects = 0 then
            return To_String(Retval);
        end if;
      if subtitle.num_rects /= 0 and then subtitle.rects = null then
        raise INTERNAL_ERROR;
      end if;
      First_Rect := subtitle.rects;
      for R in 1 .. Rects loop
          Rect := subtitle.rects.all;
          case Rect.subtitle_type is
              when subtitle_ass =>
                  Append(Retval, Get_Text_From_Ass(C.Strings.Value (Rect.ass)));
              when subtitle_none|subtitle_bitmap =>
                  return To_String(Retval);
            when others =>
              raise Program_Error with "This subtitle_type " & Rect.subtitle_type'Img  &" is not implemented yet";
          end case;
          AV_SubtitleRect_Pointers.Increment (subtitle.rects);
      end loop;
      subtitle.rects := First_Rect;
      return To_String(Retval);
    end Text;
end ffmpeg.Internal.frame.subtitle; 

