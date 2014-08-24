with ffmpeg.internal.types;
package ffmpeg.internal.codec is 

    subtype AVCodec_Access_T is ffmpeg.internal.types.AVCodec_Access_T;

    function Get_Codec (Id : Integer) return AVCodec_Access_T;
    function Open (Codec : AVCodec_Access_T; Context : ffmpeg.internal.types.AVCodec_Context_Access_T) return Boolean;

end ffmpeg.internal.codec; 

