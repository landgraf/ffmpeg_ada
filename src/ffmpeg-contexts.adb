with Ffmpeg.Stream;
with Ffmpeg.Codec_Context;
-- FIXME
with Ada.Text_IO;
package body ffmpeg.contexts is 

    procedure Close (Self : in out Context_T) is 
    begin
        Close (Self.Handler);
    end Close; 


    overriding
    procedure Initialize (Self : in out Context_T) is
    begin
        self.handler := avformat_alloc_context;
        av_register_all;
        avcodec_register_all;
    end Initialize;

    procedure Open_File (Self : in out Context_T; Filename : in String) is
    begin
        Open_File (Self.Handler, Filename);
        Read_Streams (Self);
    end Open_File;

    overriding
    procedure Finalize (Self : in out Context_T) is
    begin
        for Stream of Self.Streams_List.all loop
            Stream.Close;
        end loop;
        ffmpeg.streams.Deallocate (Self.Streams_List);
        if not Is_Null (Self.Handler)  then
            Close (Self);
        end if;
    end Finalize;

    procedure Read_Streams (Self : in out Context_T) is
        Number_Of_Streams : constant Natural := Ffmpeg.Internal.Contexts.Number_Of_Streams (Self.Handler);
        use ffmpeg.stream;
    begin
        Self.Streams_List := new Ffmpeg.Streams.Streams_T (0 .. Number_Of_Streams - 1);
        for Index in Self.Streams_List.all'Range loop
            -- Self.Streams_List.all (Index) := Construct (Get_Stream (Self.Handler, Index));
            Construct (From => Get_Stream(Self.Handler, Index), Index => Index,  Stream => Self.Streams_List.all (Index));
            Ada.Text_IO.Put_Line("Stream: " & Integer'Image (Index) & " ; " & Self.Streams_List.all(Index).Get_Type_Value);
        end loop;
    end Read_Streams;

    procedure Next_Frame (Self      : in     Context_T;
                          Frame     : in     ffmpeg.frame.frame_t;
                          End_Frame :    out Boolean) is
    begin
      Next_Frame (Self.Handler, Frame.Packet, End_Frame);
    end Next_Frame;

    function Get_Stream (Self : Context_T; Index : Natural) return ffmpeg.stream.Stream_T is (Self.Streams_List.all(Index));

end ffmpeg.contexts; 

