enum TraktExtendedInfo {
  /// Minimal info (default).
  min('min'),

  /// Complete info for the item.
  full('full'),

  /// Includes additional metadata like genres.
  metadata('metadata'),

  /// Excludes season details for shows.
  noSeasons('no_seasons'),

  /// Includes episode details for each season of a show.
  episodes('episodes'),

  /// Includes guest stars for movies and episodes.
  guestStars('guest_stars'),

  /// Includes comment counts for the item.
  comments('comments'),

  /// Includes VIP specific data.
  vip('vip');

  final String value;
  const TraktExtendedInfo(this.value);

  @override
  String toString() => value;
}
