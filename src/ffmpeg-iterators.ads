with ffmpeg.frame;
with ffmpeg.frame.video;
with ffmpeg.frame.audio;
with ffmpeg.frame.subtitle;
with ffmpeg.contexts;
package ffmpeg.iterators is 
    generic
      with procedure Video_Action (Frame : in ffmpeg.frame.video.video_t);
      with procedure Audio_Action (Frame : in ffmpeg.frame.audio.audio_t);
      with procedure Subtitle_Action (Frame : in ffmpeg.frame.subtitle.subtitle_t);
    procedure Iterate_On_Frame_G (Self : in out ffmpeg.contexts.Context_T);

end ffmpeg.iterators; 

