/// Amount of information returned by the API.
enum TraktExtendedInfo {
  /// Minimum information.
  min('min'),
  /// Metadata only.
  metadata('metadata'),
  /// Full information.
  full('full'),
  /// No episodes (for seasons).
  noEpisodes('noepisodes'),
  /// Guest stars only.
  guestStars('guest_stars'),
  /// Comments only.
  comments('comments'),
  /// VIP only info.
  vip('vip');
  /// Creates a new [TraktExtendedInfo] instance.
  const TraktExtendedInfo(this.value);
  /// The value used in API requests.
  final String value;
}
