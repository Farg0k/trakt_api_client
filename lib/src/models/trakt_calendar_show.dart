import '../core/trakt_date_utils.dart';
import 'trakt_episode.dart';
import 'trakt_show.dart';

/// Represents a show entry in a calendar.
class TraktCalendarShow {
  /// Creates a new [TraktCalendarShow] instance.
  const TraktCalendarShow({
    required this.firstAired,
    required this.episode,
    required this.show,
  });

  /// Creates a [TraktCalendarShow] from a JSON map.
  factory TraktCalendarShow.fromJson(Map<String, dynamic> json) {
    return TraktCalendarShow(
      firstAired: TraktDateUtils.parse(json['first_aired']) ?? DateTime.now(),
      episode: TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }

  /// Date when the episode airs.
  final DateTime firstAired;

  /// The episode object.
  final TraktEpisode episode;

  /// The show object.
  final TraktShow show;
}
