package ffmpeg.internal.types is 
  type AVFormatContext_T is limited null record with Convention => C;
  type AVFormatContext_Access_T is access all AVFormatContext_T with Convention => C;

  type AVOutputFormat_T is limited null record with Convention => C;
  type AVOutputFormat_Access_T is access all AVOutputFormat_T with Convention => C;

  type AVInputFormat_T is limited null record with Convention => C;
  type AVInputFormat_Access_T is access all AVInputFormat_T with Convention => C;

  type AVStream_T is limited null record with Convention => C;
  type AVStream_Access_T is access all AVStream_T with Convention => C;

  type AVDictionary_T is limited null record with Convention => C;
  type AVDictionary_Access_T is access all AVDictionary_T  with Convention => C;

  type AVDictionaryEntry_T is limited record 
    Key : C_String;
    Value : C_String;
  end record with Convention => C;

  type AVDictionaryEntry_Access_T is access all AVDictionaryEntry_T with Convention => C;

  type AVCodec_Context_T is limited null record with Convention => C, Size => 1384;
  type AVCodec_Context_Access_T is access all AVCodec_Context_T with Convention => C;

  type AVCodec_T is limited null record with Convention => C;
  type AVCodec_Access_T is access all AVCodec_T with Convention => C;

  type AVPacket_T is limited null record with Convention => C, Size => 96;
  type AVPacket_Access_T is access all AVPacket_T with Convention => C;

  type AV_Picture is limited null record with Size => 768, Convention => C;

  type Subtitle_Type_T is (SUBTITLE_NONE, SUBTITLE_BITMAP, SUBTITLE_TEXT, SUBTITLE_ASS) with Convention => C;
  for Subtitle_Type_T use (SUBTITLE_NONE => 0, SUBTITLE_BITMAP => 1, SUBTITLE_TEXT => 2, SUBTITLE_ASS => 3);
  Int_Size : constant INteger := C.Int'Size;
  type AVSubtitleRect_T is limited record 
    x : C.Int;
    y : C.Int;
    w : C.Int;
    h : C.Int;
    nb_colors : C.Int;
    Pict : AV_Picture;
    Subtitle_Type : Subtitle_Type_T;
    text : C.Strings.Chars_Ptr;
    ASS : C.Strings.Chars_Ptr;
    Flags : C.Int;
  end record with Convention => C, Size => 1216;
  for AVSubtitleRect_T use record
      x at 0 range 0 .. Int_Size - 1;
      y at 4 range 0 .. Int_Size - 1;
      w at 8  range 0 .. Int_Size - 1;
      h at 12 range 0 .. Int_Size - 1 ;
      nb_colors at 16 range 0 .. Int_Size - 1;
      Pict at 24 range 0 .. 767;
      Subtitle_Type at 120 range 0 .. Int_Size - 1;
      text at 128 range 0 .. 63;
      ass at 136 range 0 .. 63; 
      Flags at 144 range 0 .. Int_Size - 1;
  end record;

  type AVSubtitleRect_Access_T is access all AVSubtitleRect_T with Convention => C;
  type AVSubtitleRect_Access_Array_T is array (Natural range <>) of aliased AVSubtitleRect_Access_T;
  package AV_SubtitleRect_Pointers is new Interfaces.C.Pointers(Index => Natural,
  Element => AVSubtitleRect_Access_T,
  Element_Array => AVSubtitleRect_Access_Array_T,
  Default_Terminator => null);

  subtype AV_SubtitleRect_Pointer is AV_SubtitleRect_Pointers.Pointer;
  type AVSubtitle_T is limited record 
    format : Interfaces.unsigned_16;
    start_display_time : Interfaces.unsigned_32;
    end_display_time : Interfaces.unsigned_32;
    num_rects : Interfaces.unsigned_32;
    rects : AV_SubtitleRect_Pointer;
    pts : Interfaces.Integer_64;
  end record with Convention => C, Size => 256;
  for AVSubtitle_T use record
      format at 0 range 0 .. 15;
      start_display_time at 4 range 0 .. 31;
      end_display_time at 8 range 0 .. 31;
      num_rects at 12 range 0 .. 31;
      rects at 16 range 0 .. 63;
      pts at 24 range 0 .. 63;
  end record;
  type AVSubtitle_Access_T is access all AVSubtitle_T with Convention => C;

  type AVCodec_Id is (AVMEDIA_TYPE_UNKNOWN, AVMEDIA_TYPE_VIDEO, AVMEDIA_TYPE_AUDIO,
    AVMEDIA_TYPE_DATA, AVMEDIA_TYPE_SUBTITLE, AVMEDIA_TYPE_ATTACHMENT,
    AVMEDIA_TYPE_NB) with Convention => C;

  type AVFrame_T is limited null record with Convention => C, Size => 624 * 8;
  type AVFrame_Access_T is access all AVFrame_T;

  end ffmpeg.internal.types; 

