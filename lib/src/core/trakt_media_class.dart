enum TraktMediaClass {
  movies('movies'),
  shows('shows');

  final String value;
  const TraktMediaClass(this.value);

  @override
  String toString() => value;
}
