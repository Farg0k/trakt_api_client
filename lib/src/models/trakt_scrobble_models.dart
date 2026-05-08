import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_show.dart';

class TraktScrobbleRequest {
  final TraktMovie? movie;
  final TraktEpisode? episode;
  final double progress;
  final String? appVersion;
  final String? appDate;

  const TraktScrobbleRequest({
    this.movie,
    this.episode,
    required this.progress,
    this.appVersion,
    this.appDate,
  });

  Map<String, dynamic> toJson() {
    return {
      if (movie != null) 'movie': {'ids': movie!.ids?.toJson()},
      if (episode != null) 'episode': {'ids': episode!.ids?.toJson()},
      'progress': progress,
      if (appVersion != null) 'app_version': appVersion,
      if (appDate != null) 'app_date': appDate,
    };
  }
}

class TraktScrobbleResponse {
  final int id;
  final String action;
  final double progress;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktEpisode? episode;

  const TraktScrobbleResponse({
    required this.id,
    required this.action,
    required this.progress,
    this.movie,
    this.show,
    this.episode,
  });

  factory TraktScrobbleResponse.fromJson(Map<String, dynamic> json) {
    return TraktScrobbleResponse(
      id: json['id'] as int? ?? 0,
      action: json['action'] as String? ?? '',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
    );
  }
}
