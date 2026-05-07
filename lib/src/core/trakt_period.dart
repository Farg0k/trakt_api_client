enum TraktPeriod {
  daily('daily'),
  weekly('weekly'),
  monthly('monthly'),
  all('all');

  final String value;
  const TraktPeriod(this.value);

  @override
  String toString() => value;
}
