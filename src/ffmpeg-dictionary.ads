with ffmpeg.internal.types;
with ffmpeg.internal.dictionary;
use ffmpeg.internal.dictionary;
package ffmpeg.dictionary is 
    type Dictionary_T is new abstract_object with private;


    function Get_Value (Self : Dictionary_T; Key : Unbounded_String) return Unbounded_String;
    function Get_Value (Self : Dictionary_T; Key : String) return String;
    procedure Construct (Dict : out Dictionary_T; From : in ffmpeg.internal.types.AVStream_Access_T);

    overriding
    procedure Finalize (Self : in out Dictionary_T) is null;

    private

    type Dictionary_T is new abstract_object with record
        Handler : ffmpeg.internal.types.AVDictionary_Access_T := null;
    end record;

end ffmpeg.dictionary; 

