/// Types of last activity to filter progress.
enum TraktLastActivity {
  /// Last aired date.
  aired('aired'),

  /// Last collected date.
  collected('collected'),

  /// Last watched date.
  watched('watched');

  /// Creates a new [TraktLastActivity] instance.
  const TraktLastActivity(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
