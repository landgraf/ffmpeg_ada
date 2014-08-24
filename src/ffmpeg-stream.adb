package body ffmpeg.stream is 

    procedure Close (Self : in out Stream_T) is 
    begin
        Self.Codec.Close;
    end CLose; 

    function Get_Type (Self : Stream_T) return ffmpeg.codec_Context.Type_T is (Self.Codec.Get_Type);

    procedure Initialize_Codecs (Self : in out Stream_T) is
        use ffmpeg.codec_context;
    begin
        Construct (Get_Codec_Context (Self.Handler), Self.Codec);
    end Initialize_Codecs;

    function Get_Type_Value (Self : Stream_T) return String is (Ffmpeg.Codec_Context.Type_T'Image (Self.Get_Type));
    function Get_Language (Self : Stream_T) return String is (To_String (Self.Language));

    procedure Set_Language (Self : in out Stream_T) is
    begin
        Self.Language := To_Unbounded_String (Self.Dict.Get_Value ("language"));
    end Set_Language;

    procedure Construct (From   : in     AVStream_Access_T;
                         Index  : in     Natural := 0;
                         Stream :    out Stream_T) is
    begin
        Stream.Handler := From;
        Stream.Index := Index;
        ffmpeg.dictionary.construct (Stream.Dict, Stream.Handler);
        Set_Language (Stream);
        -- Initialize codec
        -- find suitable codec(-s) and open it
        Initialize_Codecs (Stream);
    end Construct;

    overriding
    procedure Finalize (Self : in out Stream_T) is
    begin
        null;
    end Finalize;

    procedure Get_Codec_Context (Self : in     Stream_T;
                                 Codec :   out ffmpeg.codec_Context.Codec_Context_T) is
    begin
        Codec := Self.Codec;
    end Get_Codec_Context;
end ffmpeg.stream; 

