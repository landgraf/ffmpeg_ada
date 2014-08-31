with Ffmpeg.codec_Context;
with ffmpeg.internal.frame.audio;
use  ffmpeg.internal.frame.audio;
package ffmpeg.frame.audio is 
  type audio_t is new frame_t with private;

  function From_Frame (Self : in out Frame_T) return Audio_T;

  procedure Decode (Self : in out audio_t; Codec : in ffmpeg.codec_context.codec_context_t);

  private

  type audio_t is new frame_t with record 
      null;
  end record;

end ffmpeg.frame.audio; 

