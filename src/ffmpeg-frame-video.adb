package body ffmpeg.frame.video is 
  function From_Frame (Self : Frame_T) return video_T is
  begin
    return (Self with null record);
  end From_Frame;

end ffmpeg.frame.video; 

