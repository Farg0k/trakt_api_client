enum TraktIdType {
  trakt('trakt'),
  imdb('imdb'),
  tmdb('tmdb'),
  tvdb('tvdb');

  final String value;
  const TraktIdType(this.value);

  @override
  String toString() => value;
}
