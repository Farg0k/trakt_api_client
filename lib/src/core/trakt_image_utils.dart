/// Helper class to generate TMDB image URLs.
///
/// Since the Trakt API doesn't return image URLs directly, you can use the
/// `tmdb` ID from the `ids` object to fetch images from the TMDB API or
/// use this helper for simple URL construction.
class TraktImageUtils {
  static const String _tmdbBaseUrl = 'https://image.tmdb.org/t/p/';

  /// Generates a TMDB image URL.
  ///
  /// [size] can be 'original', 'w500', 'h632', etc.
  /// [path] is the relative path from TMDB (e.g., /path.jpg).
  ///
  /// Note: Trakt only provides the TMDB ID, not the path. To get the actual
  /// image path, you usually need to call the TMDB API.
  static String getTmdbImageUrl({
    required String path,
    String size = 'original',
  }) {
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '$_tmdbBaseUrl$size/$cleanPath';
  }
}
