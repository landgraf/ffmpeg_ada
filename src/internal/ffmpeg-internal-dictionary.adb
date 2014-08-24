package body ffmpeg.internal.dictionary is 

    function Get_Metadata (From : ffmpeg.internal.types.AVStream_Access_T) return AVDictionary_Access_T is
        function C_Get_Metadata (Stream : in ffmpeg.internal.types.AVStream_Access_T) return AVDictionary_Access_T
            with Import, Convention => C, External_Name => "get_metadata", Pre => Stream /= null;
    begin
        return C_Get_Metadata (From);
    end Get_Metadata;
    function Get_Dict_Entry (Dict : in AVDictionary_Access_T;
        Key : String;
        Prev : AVDictionaryEntry_Access_T := null;
        Flags : in Integer := 0) return AVDictionaryEntry_Access_T is
        function av_dict_get (Dict : in AVDictionary_Access_T;
            Key : C.Strings.Chars_Ptr := C.Strings.Null_Ptr;
            Prev : in AVDictionaryEntry_Access_T := null;
            Flags : in C.Int := 0) return AVDictionaryEntry_Access_T
            with Import, Convention => C;
        Key_C : C.Strings.Chars_Ptr := C.Strings.New_String (Key);
        Result : AVDictionaryEntry_Access_T := null;
    begin
        Result := av_dict_get(Dict, Key_C, Prev, C.Int(Flags));
        C.Strings.Free (Key_C);
        return Result;
    end Get_Dict_Entry;


    function Get_Value (Self : AVDictionary_Access_T; Key : String) return String is
        use type ffmpeg.internal.types.AVDictionaryEntry_Access_T;
        Tag_Entry : AVDictionaryEntry_Access_T := null;
        function Value (Object : in AVDictionaryEntry_Access_T) return String is (C.Strings.Value (Object.Value));
    begin
        Tag_Entry := Get_Dict_Entry (Dict => Self, Key => Key, Flags => 2); -- FIXME
        if Tag_Entry /= null then
            return Value (Tag_Entry);
        end if;
        return "";
    end Get_Value;
end ffmpeg.internal.dictionary; 

