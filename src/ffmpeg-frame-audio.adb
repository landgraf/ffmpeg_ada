package body ffmpeg.frame.audio is 

  function From_Frame (Self : Frame_T) return Audio_T is
  begin
    return (Self with null record);
  end From_Frame;
end ffmpeg.frame.audio; 

