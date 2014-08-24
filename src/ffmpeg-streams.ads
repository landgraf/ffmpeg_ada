with ffmpeg.stream;
use type ffmpeg.Stream.Stream_T;
with Ada.Unchecked_Deallocation;
package ffmpeg.streams is 
    --  The package is to handle array of Streams
    --  As far as lenght of the array is not known at ellaboration time
    --  we use access to array here
    --  It can be initialized once we read main "AVFormat" type (right after open_input)
    --  And *MUST* be free'd in Finalization routine of context_t
    
    type Streams_T is array (Natural range <>) of Stream.Stream_T;
    type Streams_Access_T is access all Streams_T;

    generic
        with procedure Action (Item : ffmpeg.Stream.Stream_T);
    procedure Iterate_Over_Streams_G (Self : Streams_Access_T);

    procedure Deallocate is new Ada.Unchecked_Deallocation (Object => Streams_T, Name => Streams_Access_T);
    -- Free access type
    -- **WARNING** all element MUST be free'd before (or in their own finalizations)
    

end ffmpeg.streams; 

