with ffmpeg.internal.types;
use type ffmpeg.internal.types.AVStream_Access_T;
package ffmpeg.internal.stream is 
    subtype AVStream_Access_T is ffmpeg.internal.types.AVStream_Access_T;
    function Get_Codec_Context (Self : AVStream_Access_T) return ffmpeg.internal.types.AVCodec_Context_Access_T;

end ffmpeg.internal.stream; 

