with Ada.Strings.Unbounded; 
use  Ada.Strings.Unbounded;

with Ada.Finalization;
package ffmpeg is 
    --  Main package for *ALL* Ada representation of ffmpeg objects
    --  Only ffmpeg-internal can do not inherit this type because these packages contain
    --  Internal "C-style" procedures and should not be called outside of their corresponding "parents"
    
    type Abstract_Object is abstract new Ada.Finalization.Controlled with private;
    --  Main type to inherit from

    
    overriding
    procedure Finalize (Self : in out Abstract_Object) is abstract;
    -- abstract subprograms must be visible (RM 3.9.3(10))
    --  Force all childs to override finalize to avoid memory leaks
    --  Initialize is not forced to override as far as nothing to do in initialization routine for
    --  some types. However over types (i.e. Context, Subtitle) have their own initializator
    --  mapped to corresponding C allocator usualy

    private
    type Abstract_Object is abstract new Ada.Finalization.Controlled with null record;


end ffmpeg; 

