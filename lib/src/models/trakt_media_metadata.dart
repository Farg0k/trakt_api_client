import 'trakt_ids.dart';

/// Metadata about a media item's collection/playback state.
class TraktMediaMetadata {
  /// Creates a [TraktMediaMetadata] from a JSON map.
  factory TraktMediaMetadata.fromJson(Map<String, dynamic> json) {
    return TraktMediaMetadata(
      mediaSource: json['media_source'] as String?,
      videoResolution: json['video_resolution'] as String?,
      audio: json['audio'] as String?,
      audioChannels: json['audio_channels'] as String?,
      is3d: json['video_3d'] as bool?,
      hdr: json['hdr'] as String?,
      provider: json['provider'] as String?,
      fileName: json['file_name'] as String?,
      size: json['size'] as int?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Creates a new [TraktMediaMetadata] instance.
  const TraktMediaMetadata({
    this.mediaSource,
    this.videoResolution,
    this.audio,
    this.audioChannels,
    this.is3d,
    this.hdr,
    this.provider,
    this.fileName,
    this.size,
    this.updatedAt,
    this.ids,
  });

  /// Source of the media (e.g., 'plex', 'emby', 'nfo').
  final String? mediaSource;

  /// Video resolution (e.g., '1080p', '720p', '4k').
  final String? videoResolution;

  /// Audio format (e.g., 'DTS', 'AAC').
  final String? audio;

  /// Audio channel count (e.g., '5.1', '2.0').
  final String? audioChannels;

  /// Whether the media is in 3D.
  final bool? is3d;

  /// HDR format (e.g., 'hdr10', 'dolbyvision').
  final String? hdr;

  /// Provider/service name (if applicable).
  final String? provider;

  /// File name (if applicable).
  final String? fileName;

  /// File size in bytes.
  final int? size;

  /// When the metadata was last updated.
  final DateTime? updatedAt;

  /// IDs for the media item.
  final TraktIds? ids;

  /// Converts to JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (mediaSource != null) 'media_source': mediaSource,
      if (videoResolution != null) 'video_resolution': videoResolution,
      if (audio != null) 'audio': audio,
      if (audioChannels != null) 'audio_channels': audioChannels,
      if (is3d != null) 'video_3d': is3d,
      if (hdr != null) 'hdr': hdr,
      if (provider != null) 'provider': provider,
      if (fileName != null) 'file_name': fileName,
      if (size != null) 'size': size,
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      if (ids != null) 'ids': ids!.toJson(),
    };
  }

  @override
  String toString() {
    return '''TraktMediaMetadata{
      mediaSource: $mediaSource, 
      videoResolution: $videoResolution, 
      audio: $audio, 
      audioChannels: $audioChannels, 
      is3d: $is3d, 
      hdr: $hdr, 
      provider: $provider, 
      fileName: $fileName, 
      size: $size, 
      updatedAt: $updatedAt, 
      ids: $ids
    }''';
  }
}
