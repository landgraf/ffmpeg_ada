with Ada.Text_IO;
package body ffmpeg.internal.contexts is 

    function avformat_alloc_context return AVFormatContext_Access_T is
        function c_avformat_alloc_context return AVFormatContext_Access_T
            with Import, Convention => C, External_Name => "avformat_alloc_context";
    begin
        return c_avformat_alloc_context;
    end avformat_alloc_context;

    procedure Av_Register_All is 
        --  Initialize libavformat and register all the muxers, demuxers and
        --  protocols. If you do not call this function, then you can select
        --  exactly which formats you want to support.
        --  @see av_register_input_format()
        --  @see av_register_output_format()
        procedure c_av_register_all with Import, Convention => C, External_Name => "av_register_all";
    begin
        c_av_register_all;
    end Av_Register_All;

    procedure avcodec_register_all is
        --  Register all the codecs, parsers and bitstream filters which were enabled at
        --  configuration time. If you do not call this function you can select exactly
        --  which formats you want to support, by using the individual registration
        --  functions
        procedure c_avcodec_register_all with Import, Convention => C, External_Name => "avcodec_register_all";
    begin
        c_avcodec_register_all;
    end avcodec_register_all;

    procedure Open_File (Context    : in out AVFormatContext_Access_T;
                         Filename   : in String;
                         Format     : access ffmpeg.internal.types.AVInputFormat_T := null;
                         Options    : access ffmpeg.internal.types.AVDictionary_T := null) is
         C_Filename : C_String := C.Strings.New_String (Filename);
         Result : C.Int := C.Int'Last;
         OPEN_ERROR : exception renames Ada.Text_IO.USE_ERROR;
         use type C.Int;
         function c_avformat_open_input (
             Context  : in out AVFormatContext_Access_T;
             Filename : in C.Strings.Chars_Ptr;
             Format   : access ffmpeg.internal.types.AVInputFormat_T;
             Options  : access ffmpeg.internal.types.AVDictionary_T) 
               return C.Int with Import, Convention => C, External_Name => "avformat_open_input";
    begin
        Result := c_avformat_open_input (Context   => Context,
                                         Filename  => C_Filename,
                                         Format    => Format,
                                         Options   => Options);
        C.Strings.Free (C_Filename);
        if Result /= 0 then
            raise OPEN_ERROR;
        end if;
    exception
        when others =>
            C.Strings.Free (C_Filename);
            raise;
    end Open_File;

    procedure avformat_free_context (Self : in out AVFormatContext_Access_T) is
        -- * Free an AVFormatContext and all its streams.
        -- * @param s context to free
        procedure c_avformat_free_context (Context : in out AVFormatContext_Access_T) 
            with Import, Convention => C, External_Name => "avformat_free_context";
    begin
        c_avformat_free_context (Self);
    end avformat_free_context;


    function Is_Null (Self : AVFormatContext_Access_T) return Boolean is (Self = null);


    function Number_Of_Streams (Self : AVFormatContext_Access_T) return Natural is
        function C_Number_Of_Streams (Context : in AVFormatContext_Access_T) return C.Int
            with Import, Convention => C, External_Name => "nb_streams", Pre => Context /= null;
    begin
        return Natural (C_Number_Of_Streams (Self));
    end Number_Of_Streams;

    function Get_Stream (Self : AVFormatContext_Access_T; Index : Natural) return ffmpeg.internal.types.AVStream_Access_T is
      use type ffmpeg.internal.types.AVStream_Access_T;
        function C_Get_Stream (Context : in AVFormatContext_Access_T; Index : in C.Int) return ffmpeg.internal.types.AVStream_Access_T
            with Import, Convention => C, External_Name => "stream", Post => C_Get_Stream'Result /= null;
        Retval : ffmpeg.internal.types.AVStream_Access_T;
    begin
        Retval := C_Get_Stream (Self, C.Int(Index));
        return Retval;
    end Get_Stream;

    procedure Next_Frame (Self      : in     AVFormatContext_Access_T;
                          Packet    : in     ffmpeg.internal.types.AVPacket_Access_T;
                          End_Frame :    out Boolean) is
        function c_next_frame (Context : AVFormatContext_Access_T;
                               Packet : ffmpeg.internal.types.AVPacket_Access_T) return C.Int
            with Import, Convention => C, External_Name => "av_read_frame";
        use type C.Int;
    begin
        End_Frame := c_next_frame(Self, Packet) < 0;
    end Next_Frame;


    procedure Close (Self : in out AVFormatContext_Access_T) is
        procedure C_Close_Input (Self : in out AVFormatContext_Access_T)
            with Import, Convention => C, External_Name => "avformat_close_input";
        procedure C_Close_All (Self : in out AVFormatContext_Access_T)
            with Import, Convention => C, External_Name => "avformat_free_context";
    begin
        C_Close_Input (Self);
        if Self /= null then
            C_Close_All (Self);
        end if;
    end Close;


    --   WARNING!
    --   C function MUST be wrapped
    --   DO NOT USE RAW FUNCTION BELOW!
    --   * Return the LIBAVFORMAT_VERSION_INT constant.
    function avformat_version return Integer with Import, Convention => C;

    --  * Return the libavformat build-time configuration.
    function avformat_configuration return C.Strings.Chars_Ptr with Import, Convention => C;

    --   * Return the libavformat license.
    function avformat_license return C.Strings.Chars_Ptr with Import, Convention => C;


    -- 



end ffmpeg.internal.contexts; 

