/// Specific ID types that can be looked up.
enum TraktIdType {
  /// Trakt numeric ID.
  trakt('trakt'),
  /// IMDB ID (tt...).
  imdb('imdb'),
  /// TMDB numeric ID.
  tmdb('tmdb'),
  /// TVDB numeric ID.
  tvdb('tvdb'),
  /// TVRage numeric ID.
  tvrage('tvrage');
  /// Creates a new [TraktIdType] instance.
  const TraktIdType(this.value);
  /// The value used in API requests.
  final String value;

}
