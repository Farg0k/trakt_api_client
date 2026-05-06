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

  @override
  String toString() => value;
}
