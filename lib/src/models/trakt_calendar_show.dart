import '../core/trakt_date_utils.dart';
import 'trakt_episode.dart';
import 'trakt_show.dart';

class TraktCalendarShow {
  final DateTime firstAired;
  final TraktShow show;
  final TraktEpisode episode;

  const TraktCalendarShow({
    required this.firstAired,
    required this.show,
    required this.episode,
  });

  factory TraktCalendarShow.fromJson(Map<String, dynamic> json) {
    return TraktCalendarShow(
      firstAired: TraktDateUtils.parse(json['first_aired']) ?? DateTime.now(),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
      episode: TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>),
    );
  }
}
