enum TraktSearchField {
  title('title'),
  tagline('tagline'),
  overview('overview'),
  people('people'),
  translations('translations'),
  aliases('aliases');

  final String value;
  const TraktSearchField(this.value);

  @override
  String toString() => value;
}
