with Awda.Interfaces.ffmpeg;
procedure main is 
    -- This procedure is only for debug purpose and should be removed
    -- and package changed to library package
    ffmpeg : awda.interfaces.ffmpeg.ffmpeg_T;
begin
    ffmpeg.Open_File("file.mkv");
    ffmpeg.print_all_subtitles;
    -- ffmpeg.close;
end main; 

