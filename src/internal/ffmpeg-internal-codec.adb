package body ffmpeg.internal.codec is 

    function Open (Codec : AVCodec_Access_T; Context : ffmpeg.internal.types.AVCodec_Context_Access_T) return Boolean is
        use ffmpeg.internal.types;
        use type Interfaces.C.int;
        function c_open (COntext : AVCodec_Context_Access_T; codec : AVCodec_Access_T; dictionary : AVDictionary_Access_T) return C.Int
                    with Import, Convention => C, External_Name => "avcodec_open2";
    begin
        return c_open (Context, Codec, null) = 0; 
    end Open;

    function Get_Codec (Id : Integer) return AVCodec_Access_T is
      use type ffmpeg.internal.types.AVCodec_Access_T;
        function C_Get_Codec (Id : C.Int) return AVCodec_Access_T
            with Import, Convention => C, External_Name => "avcodec_find_decoder", Post => C_Get_Codec'Result /= null;
    begin
        return C_Get_Codec(C.Int(Id));
    end Get_Codec;
end ffmpeg.internal.codec; 

