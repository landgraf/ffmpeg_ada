with ffmpeg.internal.types;
use type ffmpeg.internal.types.AVPacket_Access_T;
use type ffmpeg.internal.types.AVFormatContext_Access_T;
package ffmpeg.internal.contexts is 

    subtype AVFormatContext_Access_T is ffmpeg.internal.types.AVFormatContext_Access_T;

    function Number_Of_Streams (Self : AVFormatContext_Access_T) return Natural;
    function Is_Null (Self : AVFormatContext_Access_T) return Boolean;
    function Get_Stream (Self : AVFormatContext_Access_T; Index : Natural) return ffmpeg.internal.types.AVStream_Access_T;
    procedure Open_File (Context    : in out AVFormatContext_Access_T;
                         Filename   : in String;
                         Format     : access ffmpeg.internal.types.AVInputFormat_T := null;
                         Options    : access ffmpeg.internal.types.AVDictionary_T := null);

    procedure Close (Self : in out AVFormatContext_Access_T)
        with Pre => Self /= null, Post => Self = null;

    procedure Av_Register_all;
    procedure avcodec_register_all;
    function Avformat_alloc_context return AVFormatContext_Access_T
        with Post => not Is_Null(Avformat_alloc_context'Result);
    procedure avformat_free_context (Self : in out AVFormatContext_Access_T) with Post => Is_Null (Self);

    procedure Next_Frame (Self      : in     AVFormatContext_Access_T;
                          Packet    : in     ffmpeg.internal.types.AVPacket_Access_T;
                          End_Frame :    out Boolean)
        with Pre => Packet /= null and Self /= null;

end ffmpeg.internal.contexts; 

