with Ada.Unchecked_Conversion;
package body ffmpeg.codec_context is 

    function Codec (Self : Codec_Context_T) return ffmpeg.Codec.Codec_T is (Self.Codec);

    procedure Construct (From    : in AVCodec_Context_Access_T;
                         Context :    out Codec_Context_T) is
        use ffmpeg.codec;
        function Value is new Ada.Unchecked_Conversion(Integer, Type_T);
    begin
        Context.Handler := From;
        Context.Codec   := Construct (Get_Codec_Id (Context.Handler), From);
        try:
        begin
            Context.Codec_Type := Value (Get_Type (Context.Handler));
        exception
            when Constraint_Error =>
                Context.Codec_Type := UNKNOWN;
        end try;
    end Construct;


    function Get_Type (Self : Codec_Context_T) return Type_T is (Self.Codec_Type);

    overriding
    procedure Finalize (Self : in out Codec_Context_T) is
        use type AVCodec_Context_Access_T;
    begin
        if Self.Handler /= null then
            null;
            -- FIXME
            -- Put_Line("Finalization : Codec_Context => " & Type_T'Image (Self.Codec_Type));
            -- Close (Self.Handler);
        end if;
    end Finalize;

    function Get_Context (Self : Codec_Context_T) return AVCodec_Context_Access_T is (Self.Handler);

    procedure Close (Self : in out Codec_Context_T) is
    begin
        if not Is_Null (Self.Handler) then
            Close (Self.Handler);
        end if;
    end Close;
end ffmpeg.codec_context; 

