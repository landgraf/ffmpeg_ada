with Ada.Text_IO; use Ada.Text_IO;
with Interfaces.C;
package size_generator is 
    procedure Generate;
    private
    filename : constant String := "src/internal/ffmpeg-internal-csizes.ads";
    package C renames Interfaces.C;

    function AVCodec_Context return C.Int
        with Import, Convention => C, External_Name => "c_avcodec_context_size";
    
    function AVPacket return C.Int
        with Import, Convention => C, External_Name => "c_avpacket_size";

    function AvPicture return C.Int
        with Import, Convention => C, External_Name =>  "c_avpicture_size";

    function AVSubtitleRect return C.Int
        with Import, Convention => C, External_Name =>  "c_subrect_size";

    function AVSubtitle return C.Int
        with Import, Convention => C, External_Name =>  "c_subtitle_size";

    function AVFrame return C.Int
        with Import, Convention => C, External_Name =>  "c_avframe_size";
end size_generator; 

