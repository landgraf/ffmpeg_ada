with ffmpeg.internal.types;
use type ffmpeg.internal.types.AVDictionary_Access_T;
use type ffmpeg.internal.types.AVStream_Access_T;
package ffmpeg.internal.dictionary is 
    subtype AVDictionary_Access_T is ffmpeg.internal.types.AVDictionary_Access_T;
    subtype AVDictionaryEntry_Access_T is ffmpeg.internal.types.AVDictionaryEntry_Access_T;

    function Get_Metadata (From : ffmpeg.internal.types.AVStream_Access_T) return AVDictionary_Access_T
        with Pre => From /= null, Post => Get_Metadata'Result /= null;

    function Get_Value (Self : AVDictionary_Access_T; Key : String) return String
        with Pre => Self /= null and then Key /= ""; 

end ffmpeg.internal.dictionary; 

