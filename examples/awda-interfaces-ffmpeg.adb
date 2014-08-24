with Ada.Text_IO;
with ffmpeg.iterators;
with ffmpeg.frame;
with ffmpeg.frame.subtitle;
with ffmpeg.frame.video;
with ffmpeg.frame.audio;
with ffmpeg.contexts;

package body awda.interfaces.ffmpeg is 

    type seconds is delta 0.01 digits 6;
    procedure Open_File (Self : in out Ffmpeg_T; Filename : String) is
    begin
        Self.Context.Open_File(Filename);
    end Open_File;

    procedure Print_All_Subtitles (Self : in out Ffmpeg_T) is

      use Ada.Text_IO;
      procedure Null_Action (Element : in Standard.ffmpeg.frame.audio.audio_t) is null;
      procedure Null_Action (Element : in Standard.ffmpeg.frame.video.video_t) is null;
      procedure Print (Element : in Standard.ffmpeg.frame.subtitle.subtitle_t) is
      begin
          if Element.Text /= "" then
              Put ("(");
              if Element.Get_Language /= "" then
                  Put(Element.Get_Language);
              end if;
              Put (")");
              Put (Seconds'Image (Seconds(Element.Start_Time)));
              Put (" -");
              Put (Seconds'Image (Seconds(Element.End_Time)));
              Put (" => ");
              Put (Element.Text);
          end if;
      end Print;

      procedure Print_All is new Standard.ffmpeg.Iterators.Iterate_on_frame_G (Subtitle_Action => Print,
                                                                               Video_Action => Null_Action,
                                                                               Audio_Action => Null_Action);
    begin
      print_all (Self.Context);
    end Print_All_Subtitles;

    procedure Close (Self : in out ffmpeg_t) is 
    begin
        Self.Context.Close;
    end CLose;
end awda.interfaces.ffmpeg; 

