import 'trakt_episode.dart';
import 'trakt_show.dart';

class TraktCalendarShow {
  final DateTime? firstAired;
  final TraktEpisode episode;
  final TraktShow show;

  const TraktCalendarShow({
    this.firstAired,
    required this.episode,
    required this.show,
  });

  factory TraktCalendarShow.fromJson(Map<String, dynamic> json) {
    return TraktCalendarShow(
      firstAired: json['first_aired'] != null
          ? DateTime.tryParse(json['first_aired'] as String)
          : null,
      episode: TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_aired': firstAired?.toIso8601String(),
      'episode': episode.toJson(),
      'show': show.toJson(),
    };
  }
}
