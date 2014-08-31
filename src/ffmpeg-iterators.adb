with ffmpeg.codec_context;

package body ffmpeg.iterators is 

    procedure Iterate_On_Frame_G (Self : in out ffmpeg.contexts.Context_T) is
        use ffmpeg.frame;
        use ffmpeg.codec_context;
    begin
        loop
            declare
                Codec : ffmpeg.codec_context.Codec_Context_T;
                Frame : Frame_T;
                Frame_Type : ffmpeg.codec_context.type_t;
                Last_Frame : Boolean := False;
            begin
                ffmpeg.contexts.Next_Frame(Self, Frame, Last_Frame);
                if Last_Frame then
                    frame.free;
                    exit;
                end if;
                exit when Last_Frame;
                frame_type := Self.Get_Stream(Frame.Index).Get_Type;
                Self.Get_Stream(Frame.Index).Get_Codec_Context(Codec);
                case frame_type is
                    when ffmpeg.codec_context.Video =>
                        declare
                            use Ffmpeg.frame.Video;
                            video : Ffmpeg.Frame.video.video_T := From_Frame (Frame);
                        begin
                            video_Action (video);
                        end;
                    when ffmpeg.codec_context.Audio =>
                        declare
                            use Ffmpeg.frame.audio;
                            Audio : Ffmpeg.Frame.Audio.Audio_T := From_Frame (Frame);
                        begin
                            Audio.Decode (Codec);
                            Audio_Action (audio);
                        end;
                    when ffmpeg.codec_context.Subtitle =>
                        declare
                            use Ffmpeg.frame.Subtitle;
                            Subtitle : Subtitle_T := From_Frame (Frame, Self.Get_Stream(Frame.Index).Get_Language);
                        begin
                            Subtitle.Decode (Codec);
                            Subtitle_Action (subtitle);
                            Free (subtitle);
                        end;
                    when others =>
                        null;
                end case;
                frame.free;
            end;
        end loop;
    end Iterate_On_Frame_G;
end ffmpeg.iterators; 

