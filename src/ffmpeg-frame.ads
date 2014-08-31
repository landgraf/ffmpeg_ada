with ffmpeg.internal.frame;
use ffmpeg.internal.frame;

package ffmpeg.frame is 
    
  DECODE_ERROR : exception;
    -- Possibly each frame type (video, audio, subtitle) could be handled in subpackages
    -- FIXME the realization is not well known yet
    
    type frame_t is new abstract_object with private;

    procedure Parse_Time (Self : in out frame_t);
    function Index (Self : in frame_t) return Natural;
    function Packet (Self : in frame_t) return AVPacket_Access_T;
    function Start_Time (Self : frame_t) return float;
    function End_Time (Self : frame_t) return float;
    procedure Free_Ptr (Frame : in out frame_t);
    procedure Free (Frame : in out Frame_T);
    
    private

    overriding
    procedure Finalize (Object : in out frame_T) is null;


    type frame_t is new abstract_object with record
        Packet     : AVPacket_Access_T := Allocate;
        Frame      : AVFrame_Access_T := null;
        -- WARNING! Do not allocate frame before really using it. It can be lead of segmentation fault in free procedure
        -- Another possible approach is to use memset and check if fields is null but perfomance can be worse
        Start_Time : float := 0.0; -- in float from the beginning 
        End_Time   : float := 0.0; 
    end record;

end ffmpeg.frame; 

