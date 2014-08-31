package body ffmpeg.frame.audio is 

  procedure Decode (Self : in out audio_t; Codec : in ffmpeg.codec_context.codec_context_t) is
  begin
      Self.Frame := Allocate;
      if ffmpeg.internal.frame.audio.Decode (Self.Frame, Codec.Get_Context, Self.Packet) < 0 then
        raise Decode_Error with "Failed to decode subtitle";
      end if;
      Self.Parse_Time;
  end Decode;

  function From_Frame (Self : in out Frame_T) return Audio_T is
      retval : audio_t := (Self with null record);
  begin
      -- Frame and Packet will be properly free'd 
      -- this hask will help to avoid double free'ing 
      Self.Frame := null;
      Self.Packet := null;
      return Retval;
  end From_Frame;
end ffmpeg.frame.audio; 

