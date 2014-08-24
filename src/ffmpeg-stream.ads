with ffmpeg.internal.stream;
use  ffmpeg.internal.stream;
with ffmpeg.codec_Context;
with ffmpeg.dictionary;
package ffmpeg.stream is 
    -- The main package to handle all stream's assotiated "external" interfaces
    
    type Stream_T is new Abstract_Object with private;

    procedure Construct (From   : in     AVStream_Access_T;
                         Index  : in     Natural := 0;
                         Stream :    out Stream_T);
    -- Construct Stream from the AVStream pointer
    -- Index here is just for perfomance/safety reasons to avoid multiple calls to underlying
    -- C wrappers. 

    function Get_Type (Self : Stream_T) return ffmpeg.codec_Context.Type_T;
    function Get_Language (Self : Stream_T) return String;

    function Get_Type_Value (Self : Stream_T) return String;
    -- Get String value of the Stream (Audio, Video, Subtitle, etc)
    
    procedure Get_Codec_Context (Self  : in     Stream_T;
                                 Codec :    out ffmpeg.codec_Context.Codec_Context_T);
    
    procedure Close (Self : in out Stream_T);
    private

    type Stream_T is new Abstract_Object with record
        Handler : AVStream_Access_T := null;
        Codec : Ffmpeg.Codec_Context.Codec_Context_T;
        Index : Natural := 0;
        Dict  : ffmpeg.dictionary.Dictionary_T;
        Language : Unbounded_String := Null_Unbounded_String;
        -- not for all streams!
    end record;
    
    overriding
    procedure Finalize (Self : in out Stream_T);
    -- Free pointers


end ffmpeg.stream; 

