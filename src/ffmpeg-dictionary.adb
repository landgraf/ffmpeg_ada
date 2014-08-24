package body ffmpeg.dictionary is 

    function Get_Value (Self : Dictionary_T; Key : Unbounded_String) return Unbounded_String is
    begin
        return To_Unbounded_String (Get_Value (Self.Handler, To_String (Key)));
    end Get_Value;

    function Get_Value (Self : Dictionary_T; Key : String) return String is
    begin
        return Get_Value (Self.Handler, Key);
    end Get_Value;

    procedure Construct (Dict : out Dictionary_T; From : in ffmpeg.internal.types.AVStream_Access_T) is
    begin
        Dict.Handler := Get_Metadata (From);
    end Construct;

end ffmpeg.dictionary; 

