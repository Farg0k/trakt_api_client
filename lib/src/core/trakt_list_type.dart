enum TraktListType {
  all('all'),
  personal('personal'),
  official('official');

  final String value;
  const TraktListType(this.value);

  @override
  String toString() => value;
}
