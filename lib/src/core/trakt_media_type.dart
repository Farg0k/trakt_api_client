/// Supported media types in Trakt.
enum TraktMediaType {
  /// All media types.
  all('all'),

  /// Movies only.
  movies('movies'),

  /// TV shows only.
  shows('shows'),

  /// Seasons only.
  seasons('seasons'),

  /// Episodes only.
  episodes('episodes'),

  /// Lists only.
  lists('lists'),

  /// People only.
  people('people');

  /// Creates a new [TraktMediaType] instance.
  const TraktMediaType(this.value);

  /// The value used in API requests.
  final String value;

  /// Returns the singular form required by some endpoints (like Search).
  String get singularValue {
    switch (this) {
      case TraktMediaType.movies:
        return 'movie';
      case TraktMediaType.shows:
        return 'show';
      case TraktMediaType.seasons:
        return 'season';
      case TraktMediaType.episodes:
        return 'episode';
      case TraktMediaType.people:
        return 'person';
      case TraktMediaType.lists:
        return 'list';
      default:
        return value;
    }
  }

  @override
  String toString() => value;
}
