/// Collection of trailer URLs for a movie.
class TraktMovieTrailers {
  /// Creates a [TraktMovieTrailers] from a JSON map.
  factory TraktMovieTrailers.fromJson(Map<String, dynamic> json) {
    final map = <String, String>{};
    json.forEach((key, value) {
      if (value is String) {
        map[key] = value;
      }
    });
    return TraktMovieTrailers(
      youtube: json['youtube'] as String?,
      quicktime: json['quicktime'] as String?,
      iphone: json['iphone'] as String?,
      ipad: json['ipad'] as String?,
      android: json['android'] as String?,
      // store any additional unknown trailer types
      additional: map,
    );
  }

  /// Creates a new [TraktMovieTrailers] instance.
  const TraktMovieTrailers({
    this.youtube,
    this.quicktime,
    this.iphone,
    this.ipad,
    this.android,
    this.additional,
  });

  /// YouTube trailer URL.
  final String? youtube;

  /// QuickTime trailer URL.
  final String? quicktime;

  /// iPhone trailer URL.
  final String? iphone;

  /// iPad trailer URL.
  final String? ipad;

  /// Android trailer URL.
  final String? android;

  /// Any additional trailer URLs by type.
  final Map<String, String>? additional;

  /// Gets a trailer URL by type, or the first available.
  String? getTrailer(String type) {
    switch (type) {
      case 'youtube':
        return youtube;
      case 'quicktime':
        return quicktime;
      case 'iphone':
        return iphone;
      case 'ipad':
        return ipad;
      case 'android':
        return android;
      default:
        return additional?[type];
    }
  }

  /// Gets any available trailer URL (prefers youtube, then first found).
  String? get any {
    if (youtube != null) return youtube;
    if (quicktime != null) return quicktime;
    if (iphone != null) return iphone;
    if (ipad != null) return ipad;
    if (android != null) return android;
    if (additional != null && additional!.isNotEmpty) {
      return additional!.values.first;
    }
    return null;
  }

  /// Converts to JSON.
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      if (youtube != null) 'youtube': youtube,
      if (quicktime != null) 'quicktime': quicktime,
      if (iphone != null) 'iphone': iphone,
      if (ipad != null) 'ipad': ipad,
      if (android != null) 'android': android,
      if (additional != null) ...additional!,
    };
    return map;
  }
}
