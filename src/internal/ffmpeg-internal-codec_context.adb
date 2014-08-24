with Ada.Unchecked_Deallocation;
package body ffmpeg.internal.codec_context is 

    function Get_Type (Self : in AVCodec_Context_Access_T) return Integer is
        function c_codec_type (Self : in AVCodec_Context_Access_T) return C.Int 
            with Import, Convention => C;
    begin
        return INteger (C_Codec_Type (Self));
    end Get_Type;

    function Get_Codec_Id (Self : AVCodec_Context_Access_T) return Integer is
      use type ffmpeg.internal.types.AVCodec_Context_Access_T;
        function C_Get_Codec_Id (Ctx : in AVCodec_Context_Access_T) return C.Int
            with Import, Convention => C, External_Name => "codec_id", Pre => Ctx /= null;
    begin
        return Integer (C_Get_Codec_Id (Self));
    end Get_Codec_Id;

    procedure Close (Codec : in out AVCodec_Context_Access_T) is
        function c_avcodec_is_open ( Codec : AVCodec_Context_Access_T) return C.Int
            with Import, Convention => C, External_Name => "avcodec_is_open";
        function c_avcodec_close(Codec : AVCodec_Context_Access_T) return C.Int
            with Import, Convention => C, External_Name => "avcodec_close";
        procedure Free is new Ada.Unchecked_Deallocation (Name => AVCodec_Context_Access_T, Object => ffmpeg.internal.types.AVCodec_Context_T);


        use type C.Int;
        Result : C.Int := 0;
    begin
        if c_avcodec_is_open (Codec) > 0 then
            Result := c_avcodec_close (Codec);
        end if;
        if Result /= 0 then
            raise Program_Error with "Codec close failed";
        end if;
        -- Free(Codec);
    end Close;

end ffmpeg.internal.codec_context; 

