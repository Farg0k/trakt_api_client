/// Specific fields that can be searched.
enum TraktSearchField {
  /// Search in titles.
  title('title'),

  /// Search in taglines.
  tagline('tagline'),

  /// Search in overviews.
  overview('overview'),

  /// Search in people.
  people('people'),

  /// Search in translations.
  translations('translations'),

  /// Search in aliases.
  aliases('aliases');

  /// Creates a new [TraktSearchField] instance.
  const TraktSearchField(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
