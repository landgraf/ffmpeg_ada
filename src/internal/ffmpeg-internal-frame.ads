with ffmpeg.Internal.types;
use type ffmpeg.internal.types.AVPacket_Access_T;
package ffmpeg.Internal.frame is 
  subtype AVPacket_Access_T is ffmpeg.Internal.types.AVPacket_Access_T;

  function Is_Null (Self : AVPacket_Access_T) return Boolean is (Self = null);
  procedure Free (Self : in out AVPacket_Access_T)
        with Pre => Self /= null, Post => Self = null;
  function Index (Self : in AVPacket_Access_T) return Natural;
  function Allocate return AVPacket_Access_T;
  procedure Deallocate (Self : in out AVPacket_Access_T);

end ffmpeg.Internal.frame; 

