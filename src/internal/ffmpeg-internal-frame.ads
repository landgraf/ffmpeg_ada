with ffmpeg.Internal.types;
use type ffmpeg.internal.types.AVPacket_Access_T;
use type ffmpeg.internal.types.AVFrame_Access_T;
package ffmpeg.Internal.frame is 
  subtype AVPacket_Access_T is ffmpeg.Internal.types.AVPacket_Access_T;
  subtype AVFrame_Access_T is ffmpeg.internal.types.AVFrame_Access_T;
  subtype AVFrame_T is ffmpeg.internal.types.AVFrame_T;
  Time_Base : constant Float := ffmpeg.internal.time_base;

  function Timestamp (Frame : AVFrame_Access_T)  return Float;
  function Duration (Frame : AVFrame_Access_T) return Float;
  function Allocate return AVFrame_Access_T;
  function Is_Null (Self : AVPacket_Access_T) return Boolean is (Self = null);
  function Is_Null (Self : AVFrame_Access_T) return Boolean is (Self = null);
  procedure Free (Self : in out AVPacket_Access_T)
        with Pre => Self /= null, Post => Self = null;
  procedure Free (Self : in out AVFrame_Access_T)
        with Pre => Self /= null, Post => Self = null;
  function Index (Self : in AVPacket_Access_T) return Natural;
  function Allocate return AVPacket_Access_T;
  procedure Deallocate (Self : in out AVPacket_Access_T);

end ffmpeg.Internal.frame; 

