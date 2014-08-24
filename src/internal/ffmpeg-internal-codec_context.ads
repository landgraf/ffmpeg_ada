with  ffmpeg.internal.types;
use type ffmpeg.internal.types.AVCodec_Context_Access_T;
package ffmpeg.internal.codec_context is 

    -- Internal representation of AVCodec_Context ffmpeg type
    
    subtype AVCodec_Context_Access_T is ffmpeg.internal.types.AVCodec_Context_Access_T;
    
    procedure Close (Codec : in out AVCodec_Context_Access_T)
        with Pre => Codec /= null;
    --  Wrapper of av_close_input 

    function Is_Null (Self : AVCodec_Context_Access_T) return Boolean is (Self = null);
    function Get_Codec_Id (Self : AVCodec_Context_Access_T) return Integer;
    -- Return Id of the assotiated codec
    
    
    function Get_Type (Self : in AVCodec_Context_Access_T) return Integer;
    --  Getter for codec_context_type (Audio, Video, Subtitle, Attachment);
    
end ffmpeg.internal.codec_context; 

