with Ada.Unchecked_Deallocation;
package body ffmpeg.internal.frame is 

    procedure Free (Self : in out AVPacket_Access_T)  is
        procedure Free_Ptr is new Ada.Unchecked_Deallocation (Name => AVPacket_Access_T, Object => ffmpeg.internal.types.AVPacket_T);
        procedure c_free (Packet : AVPacket_Access_T)
            with Import, Convention => C, External_Name => "av_free_packet";
    begin
        C_free (Self);
        if Self /= null then
            Free_Ptr (Self);
        end if;
    end Free;

    function Index (Self : in AVPacket_Access_T) return Natural is
      function c_index (Packet : AVPacket_Access_T) return C.Int
        with Import, Convention => C, External_Name => "c_stream_index";
    begin
      return Natural (c_index (Self));
    end Index;

    function Allocate return AVPacket_Access_T is
        function C_Allocate_Packet return AVPacket_Access_T
            with Import, Convention => C, External_Name => "c_allocate_packet";
     begin
         return C_Allocate_Packet;
     end Allocate;
    procedure Deallocate (Self : in out AVPacket_Access_T) is
        procedure C_Deallocate (Packet : AVPacket_Access_T)
            with Import, Convention => C, External_Name => "av_free_packet";
    begin
        C_Deallocate (Self);
    end Deallocate;
end ffmpeg.internal.frame; 

