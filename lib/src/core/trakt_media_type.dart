enum TraktMediaType {
  all('all'),
  movies('movies'),
  shows('shows'),
  seasons('seasons'),
  episodes('episodes'),
  lists('lists'),
  people('people');

  final String value;
  const TraktMediaType(this.value);

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
