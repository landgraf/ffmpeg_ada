#include <libavformat/avformat.h>
#include <libavutil/avutil.h>
/**
 *  Set of simple wrappers to access internal structure of C types
 *  which is not directly accessible from Ada code
 *  See ffmpeg documentation and avformat.h comments
 *
 */

int nb_streams (AVFormatContext *fmt_ctx){
    return fmt_ctx->nb_streams;
}

AVStream *stream (AVFormatContext *fmt_ctx,  int stream_idx){
    return fmt_ctx->streams[stream_idx];
}

AVCodecContext *codec_context (AVStream *strm){
    return strm->codec;
}

enum AVCodecID codec_id (AVCodecContext *ctx){
    return ctx->codec_id;
}

const char *codec_name (AVCodec *dec){
    return dec->name;
}

enum AVMediaType c_codec_type (AVCodecContext *ctx){
    return ctx->codec_type;
}

AVDictionary *get_metadata (AVStream *strm){
    return strm->metadata;
}

AVPacket *c_allocate_packet(){
    AVPacket *avpkt = (AVPacket *)malloc(sizeof(AVPacket) * 1);
    av_init_packet(avpkt);  
    return avpkt;
}

int c_stream_index(AVPacket *pkt)
{
    return pkt->stream_index;
}

int av_time_base(){
    int base = AV_TIME_BASE;
    return base;
}

