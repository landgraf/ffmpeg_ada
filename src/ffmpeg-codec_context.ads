with ffmpeg.codec;
with ffmpeg.internal.codec_context;
use  ffmpeg.internal.codec_context;
package ffmpeg.codec_context is

    -- This package handles all external information for avcodec_context
    -- See internal package ffmpeg.internal.codec_context for internal representation
    

    type Codec_Context_T is new Abstract_Object with private;

    type Type_T is (Unknown, Video, Audio, Data, Subtitle, Attachment, NB);
    for Type_T use (Unknown => -1, Video => 0, Audio => 1, Data => 2, Subtitle => 3, Attachment => 4, NB => 5);


    procedure Construct (From    : in AVCodec_Context_Access_T;
                         Context :    out Codec_Context_T);
    -- Constructs Codec_Context using C pointer. 

    procedure Close (Self : in out Codec_Context_T);

    function Codec (Self : Codec_Context_T) return ffmpeg.codec.Codec_T;
    -- Returns codec assotiated with the contexts, 
    
    
    function Get_Type (Self : Codec_Context_T) return Type_T;
    -- Get type of Codec (Stream). See type_t above

    function Get_Context (Self : Codec_Context_T) return AVCodec_Context_Access_T;
    
    private

    type Codec_Context_T is new Abstract_Object with record
        Handler : AVCodec_Context_Access_T;
        Codec : ffmpeg.Codec.Codec_T;
        Codec_Type : Type_T;
    end record;
    
    overriding
    procedure Finalize (Self : in out Codec_Context_T);
    -- Close codec handler
    
end ffmpeg.codec_context; 

