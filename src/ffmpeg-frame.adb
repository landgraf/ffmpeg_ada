package body ffmpeg.frame is 


    procedure Free (Frame : in out Frame_T) is 
    begin
        if not Is_Null (Frame.Packet)  then
            Free (Frame.Packet);
        end if;
    end Free;


    function Index (Self : in Frame_T) return Natural is (Index(Self.Packet));
    function Start_Time (Self : frame_t) return float is (Self.Start_Time);
    function End_Time (Self : frame_t) return float is (Self.End_Time);
    function Packet (Self : in frame_t) return AVPacket_Access_T is (Self.Packet);
end ffmpeg.frame; 

