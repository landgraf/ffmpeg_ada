package ffmpeg.frame.video is 
  type video_t is new frame_t with private;
  function From_Frame (Self : Frame_T) return video_T;

  private
  type video_t is new frame_t with null record;

end ffmpeg.frame.video; 

