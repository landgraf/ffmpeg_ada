package body ffmpeg.internal.frame.audio is 


  function Decode (Audio : AVFrame_Access_T; Codec : AVCodec_Context_Access_T; Packet : AVPacket_Access_T) return Integer is
      Got_Frame : aliased C.Int;
      use type C.Int;
      function C_Decode (ctx : AVCodec_Context_Access_T;
          frame : AVFrame_Access_T;
          got_frame : access C.Int;
          pkt   : AVPacket_Access_T) return C.Int
          with Import, Convention => C, External_Name => "avcodec_decode_audio4";
  begin
      if c_decode (Codec, Audio, got_frame'Access, Packet) >= 0 then
          return Integer (Got_Frame);
      end if;
      return -1;
  end Decode;
end ffmpeg.internal.frame.audio; 

