package body ffmpeg.streams is 

    procedure Iterate_Over_Streams_G (Self : Streams_Access_T) is
    begin
        for Strm of Self.all loop
            Action (Strm);
        end loop;
    end Iterate_Over_Streams_G;
end ffmpeg.streams; 

