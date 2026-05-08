enum TraktLastActivity {
  aired('aired'),
  collected('collected'),
  watched('watched');

  final String value;
  const TraktLastActivity(this.value);

  @override
  String toString() => value;
}
