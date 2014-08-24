with Interfaces;

package body ffmpeg.frame.subtitle is 

    function Text (Self : subtitle_t) return String is (To_String (Self.Text));

    procedure Free (Self : in out subtitle_t) is 
    begin
        Deallocate (Self.Handler);
        Free (Self.Handler);
    end Free;

    overriding
    procedure Initialize (Self : in out subtitle_t) is
    begin
        Self.Handler := Allocate;
    end Initialize;

    function From_Frame (Self : Frame_T; Language : String := "") return Subtitle_T is
    begin
      return (Self with Text => Null_Unbounded_String,
      Handler => Allocate,
      Language => To_Unbounded_String (Language),
      Subtitle_type =>  SUBTITLE_NONE);
    end From_Frame;


    procedure Decode (Self : in out subtitle_t; Codec : in ffmpeg.codec_context.codec_context_t) is
      use type Interfaces.Unsigned_32;
    begin
      if ffmpeg.internal.frame.subtitle.Decode (Self.Handler, Codec.Get_Context, Self.Packet) < 0 then
        raise Decode_Error with "Failed to decode subtitle";
      end if;
      if Self.handler.num_rects > 1 then
        raise Program_Error with "Number or rects > 1. Not implemented";
      end if;
      Self.Text := To_Unbounded_String (Text (Self.Handler));
      Self.Start_Time := Start_Time (Self.Handler);
      Self.End_Time   := End_Time (Self.Handler);
    end Decode;

    function Get_Language (Self : Subtitle_T) return String is (To_String (Self.Language));
    function Get_Language (Self : Subtitle_T) return Unbounded_String is (Self.Language);

end ffmpeg.frame.subtitle; 

