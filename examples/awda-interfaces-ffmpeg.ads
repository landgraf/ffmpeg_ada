with ffmpeg.contexts;
package awda.interfaces.ffmpeg is 
    type Ffmpeg_T is new Ada.Finalization.Limited_Controlled with private;

    procedure Open_File (Self : in out Ffmpeg_T; Filename : String);

    procedure Print_All (Self : in out Ffmpeg_T);

    procedure Close (Self : in out ffmpeg_t);
    private

    type Ffmpeg_T is new Ada.Finalization.Limited_Controlled with record
        Context : Standard.Ffmpeg.Contexts.Context_T;
    end record;

end awda.interfaces.ffmpeg; 

