package body ffmpeg.internal.stream is

    function Get_Codec_Context (Self : AVStream_Access_T) return ffmpeg.internal.types.AVCodec_Context_Access_T is
      use type ffmpeg.internal.types.AVStream_Access_T;
        function C_Get_Codec_Context (Stream : in ffmpeg.internal.types.AVStream_Access_T) return ffmpeg.internal.types.AVCodec_Context_Access_T
            with Import, Convention => C, External_Name => "codec_context", Pre => Stream /= null;
    begin
        return C_Get_Codec_Context (Self);
    end Get_Codec_Context;
end ffmpeg.internal.stream; 

