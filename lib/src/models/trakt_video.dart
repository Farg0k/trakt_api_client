/// Represents a video related to a movie or show (e.g. trailer, teaser).
class TraktVideo {
  /// Creates a [TraktVideo] from a JSON map.
  factory TraktVideo.fromJson(Map<String, dynamic> json) {
    return TraktVideo(
      name: json['name'] as String? ?? '',
      site: json['site'] as String? ?? '',
      key: json['key'] as String? ?? '',
      type: json['type'] as String? ?? '',
      official: json['official'] as bool?,
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'] as String)
          : null,
      country: json['country'] as String?,
    );
  }

  /// Creates a new [TraktVideo] instance.
  const TraktVideo({
    required this.name,
    required this.site,
    required this.key,
    required this.type,
    this.official,
    this.publishedAt,
    this.country,
  });

  /// Name of the video.
  final String name;

  /// Site where the video is hosted (e.g. youtube).
  final String site;

  /// Key/ID of the video on the hosting site.
  final String key;

  /// Type of video (e.g. Trailer, Teaser, Clip).
  final String type;

  /// Whether this is an official video.
  final bool? official;

  /// When the video was published.
  final DateTime? publishedAt;

  /// 2-character country code.
  final String? country;

  /// Converts this video to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'site': site,
      'key': key,
      'type': type,
      if (official != null) 'official': official,
      if (publishedAt != null) 'published_at': publishedAt!.toIso8601String(),
      if (country != null) 'country': country,
    };
  }

  @override
  String toString() {
    return '''TraktVideo{
      name: $name, 
      site: $site, 
      key: $key, 
      type: $type, 
      official: $official, 
      publishedAt: $publishedAt, 
      country: $country
    }''';
  }
}
