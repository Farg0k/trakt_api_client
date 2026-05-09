/// Time periods for filtering trends and stats.
enum TraktPeriod {
  /// Daily period.
  daily('daily'),

  /// Weekly period.
  weekly('weekly'),

  /// Monthly period.
  monthly('monthly'),

  /// All time.
  all('all');

  /// Creates a new [TraktPeriod] instance.
  const TraktPeriod(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
