with ffmpeg.internal.types; 
use ffmpeg.internal.types;
package ffmpeg.internal.frame.audio is 

    subtype AVFrame_Access_T is ffmpeg.internal.types.AVFrame_Access_T;

    function Decode (Audio : AVFrame_Access_T; Codec : AVCodec_Context_Access_T; Packet : AVPacket_Access_T) return Integer;
end ffmpeg.internal.frame.audio; 

