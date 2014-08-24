package body ffmpeg.codec is 

    function Construct (Id : Integer; Context : ffmpeg.internal.types.AVCodec_Context_Access_T) return Codec_T is
        -- FIXME layers violation!!!
        use type ffmpeg.internal.types.AVCodec_Context_Access_T;
        use type AVCodec_Access_T;
        Retval : Codec_T;
    begin
        Retval.Handler := Get_Codec (Id);
        if Retval.Handler = null or else not Open (Retval.Handler, Context) then
            raise CODEC_ERROR with "Unable to open codec";
        end if;
        return Retval;
    end Construct;

    overriding
    procedure Finalize (Self : in out Codec_T) is
    begin
        null;
        -- FIXME
    end Finalize;
end ffmpeg.codec; 

