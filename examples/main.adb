with Awda.Interfaces.ffmpeg;
with Ada.Command_Line;
procedure main is 
    -- This procedure is only for debug purpose and should be removed
    -- and package changed to library package
    ffmpeg : awda.interfaces.ffmpeg.ffmpeg_T;
    function FIlename return String is ((if Ada.Command_Line.Argument_Count > 0 then Ada.Command_Line.Argument (1) else ""));
begin
    ffmpeg.Open_File(Filename);
    ffmpeg.print_all_subtitles;
    -- ffmpeg.close;
end main; 

