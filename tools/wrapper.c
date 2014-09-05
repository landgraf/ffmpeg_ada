#include <libavformat/avformat.h>
#include <libavutil/avutil.h>

int c_avcodec_context_size(){
    return sizeof(AVCodecContext);
}

int c_avpacket_size(){
    return sizeof(AVPacket);
}

int c_avpicture_size(){
    return sizeof(AVPicture);
}

int c_subrect_size(){
    return sizeof(AVSubtitleRect);
}

int c_subtitle_size(){
    return sizeof(AVSubtitle);
}

int c_avframe_size(){
    return sizeof(AVFrame);
}
