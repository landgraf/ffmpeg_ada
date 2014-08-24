with ffmpeg.internal.contexts;
use  ffmpeg.internal.contexts;
with ffmpeg.internal.types;
with Ffmpeg.Streams;
with Ffmpeg.Stream;
with ffmpeg.frame;
package ffmpeg.contexts is 

    -- "Main" entry for all operations with multimedia file
    --  Contains AVFormatContext inside and list of Streams to operate with
    
    type Context_T is new Abstract_Object with private;

    procedure Close (Self : in out Context_T);

    procedure Next_Frame (Self      : in     Context_T;
                          Frame     : in     ffmpeg.frame.frame_t;
                          End_Frame :    out Boolean);

    procedure Open_File (Self : in out Context_T; Filename : in String);
    --  Open context from file and initialize all related objects (i.e. Streams, Codecs)

    function Get_Stream (Self : Context_T; Index : Natural) return ffmpeg.stream.Stream_T;
    private

    type Context_T is new Abstract_Object with record
        Handler : AVFormatContext_Access_T;
        Streams_List : Streams.Streams_Access_T;
    end record;


    procedure Read_Streams (Self : in out Context_T);
    -- Initialize/read streams info and complete Self.Streams list 

    overriding
    procedure Finalize (Self : in out Context_T);
    --  Finalize Stream_List pointer

    overriding
    procedure Initialize (Self : in out Context_T);
    -- Perform "Internal" ffmpeg startup operations
    -- like codec registration
    
end ffmpeg.contexts; 

