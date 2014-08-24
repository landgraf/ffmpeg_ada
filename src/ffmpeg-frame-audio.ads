package ffmpeg.frame.audio is 
  type audio_t is new frame_t with private;

  function From_Frame (Self : Frame_T) return Audio_T;
  private

  type audio_t is new frame_t with null record;

end ffmpeg.frame.audio; 

