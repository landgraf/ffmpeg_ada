with ffmpeg.codec_context;
with ffmpeg.internal.frame.subtitle;
use ffmpeg.internal.frame.subtitle;
package ffmpeg.frame.subtitle is
    -- The main package to handle all subtitle information
    -- Subtitle inherits all frame fields (Start and End time) and adds its own ones
    
    type subtitle_t is new frame_t with private;
    
    type Subtitle_Type_T is (SUBTITLE_NONE, SUBTITLE_BITMAP, SUBTITLE_TEXT, SUBTITLE_ASS) with Convention => C;
    for Subtitle_Type_T use (SUBTITLE_NONE => 0, SUBTITLE_BITMAP => 1, SUBTITLE_TEXT => 2, SUBTITLE_ASS => 3);

    function Get_Language (Self : Subtitle_T) return String;
    function Get_Language (Self : Subtitle_T) return Unbounded_String;
    function From_Frame (Self : Frame_T; Language : String := "") return Subtitle_T;
    function Text (Self : subtitle_t) return String;
    --  Getter for Text assotiated with subtitle_t
    --
    procedure Decode (Self : in out subtitle_t; Codec : in ffmpeg.codec_context.codec_context_t);

    
    procedure Free (Self : in out subtitle_t);
    overriding
    procedure Initialize (Self : in out subtitle_t);

    private
    type subtitle_t is new frame_t with record
        Handler : AVSubtitle_Access_T; 
        Text : Unbounded_String;
        subtitle_type : Subtitle_Type_T;
        Language : Unbounded_String;
        -- TODO Subtitle and audio streams contain language info and could be grouped in interface
    end record;
    
    overriding
    procedure Finalize (Self : in out subtitle_t) is null;
    -- Finalize subtitle (call av_free_subtitle in internal package)

end ffmpeg.frame.subtitle; 

