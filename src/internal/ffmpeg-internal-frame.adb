with Ada.Unchecked_Deallocation;
with System;
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

    procedure Free (Self : in out AVFrame_Access_T)  is
        procedure Free_Ptr is new Ada.Unchecked_Deallocation (Name => AVFrame_Access_T, Object => ffmpeg.internal.types.AVFrame_T);
        procedure c_free (Frame : in out AVFrame_Access_T)
            with Import, Convention => C, External_Name => "c_free_frame";
            -- with Import, Convention => C, External_Name => "av_frame_free";
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

  function Allocate return AVFrame_Access_T is
  begin
      return new AVFrame_T;
  end Allocate;

    procedure Deallocate (Self : in out AVPacket_Access_T) is
        procedure C_Deallocate (Packet : AVPacket_Access_T)
            with Import, Convention => C, External_Name => "av_free_packet";
    begin
        C_Deallocate (Self);
    end Deallocate;

    function Duration (Frame : AVFrame_Access_T) return Float is
      function C_Duration (Frame : AVFrame_Access_T) return Interfaces.Unsigned_64
          with Import, Convention => C, External_Name => "av_frame_get_pkt_duration";
    begin
        return Float (C_Duration (Frame))/ 1000.0;
    end Duration;
  function Timestamp (Frame : AVFrame_Access_T)  return Float is
      function C_Timestamp (Frame : AVFrame_Access_T) return Interfaces.Unsigned_64
          with Import, Convention => C, External_Name => "av_frame_get_best_effort_timestamp";
  begin
      return Float (C_Timestamp (Frame)) / 1000.0;
  end Timestamp;
end ffmpeg.internal.frame; 

