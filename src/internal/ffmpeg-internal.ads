with Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Pointers;
package ffmpeg.internal is 
    --  This package and all child packages contain internal information
    --  (mappings/wrappers of C methods mainly)
    --
    --  ATTENTION!
    --
    --  Do not return *ANY* internal types (i.e. starting with AV*)
    --  The only exception is if the "internal" type is hidden in chain of calls
    
    package C renames Interfaces.C;
    package C_Strings renames Interfaces.C.Strings;
    subtype C_String is C_Strings.Chars_Ptr;
    INTERNAL_ERROR : exception;
    --  Every internal package can raise this and only this exception
    --  Parents should properly handle the exception (*sigh*)
    function Get_Time_Base return Natural
        with Import, Convention => C, External_Name => "av_time_base";
    
    Time_Base : constant Float := Float(Get_Time_Base);
end ffmpeg.internal; 

