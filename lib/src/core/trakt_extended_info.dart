/// Extended info parameters to control the level of detail returned by the Trakt API.
class TraktExtendedInfo {
  /// Minimal info (default).
  static const String min = 'min';

  /// Complete info for the item.
  static const String full = 'full';

  /// Includes additional metadata like images and genres.
  static const String metadata = 'metadata';

  /// Excludes season details for shows.
  static const String noSeasons = 'no_seasons';

  /// Includes episode details for each season of a show.
  static const String episodes = 'episodes';

  /// Includes guest stars for movies and episodes.
  static const String guestStars = 'guest_stars';

  /// Includes comment counts for the item.
  static const String comments = 'comments';
}
