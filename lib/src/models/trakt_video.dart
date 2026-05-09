class TraktVideo {
  const TraktVideo({
    required this.name,
    required this.site,
    required this.key,
    required this.type,
    required this.size,
    required this.traktId,
  });

  factory TraktVideo.fromJson(Map<String, dynamic> json) {
    return TraktVideo(
      name: json['name'] as String,
      site: json['site'] as String,
      key: json['key'] as String,
      type: json['type'] as String,
      size: json['size'] as int,
      traktId: json['ids']['trakt'] as int,
    );
  }
  final String name;
  final String site;
  final String key;
  final String type;
  final int size;
  final int traktId;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'site': site,
      'key': key,
      'type': type,
      'size': size,
      'ids': {'trakt': traktId},
    };
  }

  String? get url {
    if (site.toLowerCase() == 'youtube') {
      return 'https://www.youtube.com/watch?v=$key';
    } else if (site.toLowerCase() == 'vimeo') {
      return 'https://vimeo.com/$key';
    }
    return null;
  }
}
