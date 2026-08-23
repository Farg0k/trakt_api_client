/// Avatar images for a user profile.
class TraktUserImages {
  /// Creates a [TraktUserImages] from a JSON map.
  factory TraktUserImages.fromJson(Map<String, dynamic> json) {
    return TraktUserImages(
      avatar: json['avatar'] as String?,
      fullSize: json['full_size'] as String?,
      thumb60: json['thumb_60'] as String?,
      thumb128: json['thumb_128'] as String?,
      thumb256: json['thumb_256'] as String?,
      thumb512: json['thumb_512'] as String?,
    );
  }

  /// Creates a new [TraktUserImages] instance.
  const TraktUserImages({
    this.avatar,
    this.fullSize,
    this.thumb60,
    this.thumb128,
    this.thumb256,
    this.thumb512,
  });

  /// Full-size avatar URL.
  final String? avatar;

  /// Full-size avatar URL (alias for avatar).
  final String? fullSize;

  /// 60px thumb URL.
  final String? thumb60;

  /// 128px thumb URL.
  final String? thumb128;

  /// 256px thumb URL.
  final String? thumb256;

  /// 512px thumb URL.
  final String? thumb512;

  /// Converts to JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (avatar != null) 'avatar': avatar,
      if (fullSize != null) 'full_size': fullSize,
      if (thumb60 != null) 'thumb_60': thumb60,
      if (thumb128 != null) 'thumb_128': thumb128,
      if (thumb256 != null) 'thumb_256': thumb256,
      if (thumb512 != null) 'thumb_512': thumb512,
    };
  }

  @override
  String toString() {
    return '''TraktUserImages{
      avatar: $avatar, 
      fullSize: $fullSize, 
      thumb60: $thumb60, 
      thumb128: $thumb128, 
      thumb256: $thumb256, 
      thumb512: $thumb512
    }''';
  }
}
