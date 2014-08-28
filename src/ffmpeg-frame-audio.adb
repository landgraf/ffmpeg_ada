package body ffmpeg.frame.audio is 

  procedure Decode (Self : in out audio_t; Codec : in ffmpeg.codec_context.codec_context_t) is
  begin
      if ffmpeg.internal.frame.audio.Decode (Self.Handler, Codec.Get_Context, Self.Packet) < 0 then
        raise Decode_Error with "Failed to decode subtitle";
      end if;
  end Decode;

  function From_Frame (Self : Frame_T) return Audio_T is
  begin
    return (Self with null);
  end From_Frame;
end ffmpeg.frame.audio; 

