with Interfaces.C.Pointers;
with ffmpeg.internal.types;
use ffmpeg.internal.types;
with Ada.Unchecked_Deallocation;
package ffmpeg.Internal.frame.subtitle is 
    Time_Base : constant Float := ffmpeg.internal.time_base;

    procedure Free is new Ada.Unchecked_Deallocation (Name => ffmpeg.internal.types.AVSubtitle_Access_T, Object => AVSubtitle_T);
    subtype AVSubtitle_Access_T is ffmpeg.internal.types.AVSubtitle_Access_T; 

    function Is_Null (Subtitle : AVSubtitle_Access_T) return Boolean is (Subtitle = null);

    function Text (Subtitle : in AVSubtitle_Access_T; Rects : Natural := 1) return String;

    function PTS (Subtitle : in AVSubtitle_Access_T) return Float is (float(Subtitle.PTS) / Time_Base );
    function End_Time (Subtitle : in AVSubtitle_Access_T)  return float is
      ( PTS (Subtitle) + Float(Subtitle.End_Display_Time) / 1000.0);
    function Start_Time (Subtitle : in AVSubtitle_Access_T) return float is
      (PTS (Subtitle) + Float (Subtitle.Start_Display_Time) / 1000.0);


    function Decode (Subtitle : in AVSubtitle_Access_T; Codec : AVCodec_Context_Access_T; Packet : AVPacket_Access_T) return Integer;

    function Allocate return AVSubtitle_Access_T
        with Post => Allocate'Result /= null;

    procedure Deallocate (Self : in AVSubtitle_Access_T)
        with Pre => Self /= null;

end ffmpeg.Internal.frame.subtitle; 

