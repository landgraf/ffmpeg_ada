with ffmpeg.internal.codec;
use  ffmpeg.internal.codec;
with  ffmpeg.internal.types;
package ffmpeg.codec is 

    CODEC_ERROR : exception;
    -- This package hanles all external interfaces to AVCodec type
    -- See ffmpeg.internal.codec for internal representation
    
    type Codec_T is new Abstract_Object with private;
    
    function Construct (Id : Integer; Context : ffmpeg.internal.types.AVCodec_Context_Access_T) return Codec_T; 
    --  Construct codec using codec_id

    
    private

    type Codec_T is new Abstract_Object with record
        Handler : AVCodec_Access_T;
    end record;
    
    overriding
    procedure Finalize (Self : in out Codec_T);
    -- Finalize codec_t; Nothing to do so far. Codec is closed in Finalize routine
    -- of codec_context_t


end ffmpeg.codec; 

