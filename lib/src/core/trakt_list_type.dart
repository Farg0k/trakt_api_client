/// Types of lists that can be retrieved.
enum TraktListType {
  /// All list types.
  all('all'),

  /// Personal lists created by users.
  personal('personal'),

  /// Official lists from Trakt or partners.
  official('official');

  /// Creates a new [TraktListType] instance.
  const TraktListType(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
