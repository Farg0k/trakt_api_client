import '../core/trakt_date_utils.dart';
import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_sharing.dart';
import 'trakt_show.dart';

class TraktCheckinRequest {
  const TraktCheckinRequest({
    this.movie,
    this.episode,
    this.show,
    this.message,
    this.sharing,
    this.appVersion,
    this.appDate,
  });
  final TraktMovie? movie;
  final TraktEpisode? episode;
  final TraktShow? show;
  final String? message;
  final TraktSharing? sharing;
  final String? appVersion;
  final String? appDate;

  Map<String, dynamic> toJson() {
    return {
      if (movie != null) 'movie': {'ids': movie!.ids?.toJson()},
      if (episode != null) 'episode': {'ids': episode!.ids?.toJson()},
      if (show != null) 'show': {'ids': show!.ids?.toJson()},
      if (sharing != null) 'sharing': sharing!.toJson(),
      if (message != null) 'message': message,
      if (appVersion != null) 'app_version': appVersion,
      if (appDate != null) 'app_date': appDate,
    };
  }
}

class TraktCheckinResponse {
  const TraktCheckinResponse({
    this.watchedAt,
    this.expiresAt,
    this.movie,
    this.show,
    this.episode,
  });

  factory TraktCheckinResponse.fromJson(Map<String, dynamic> json) {
    return TraktCheckinResponse(
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      expiresAt: TraktDateUtils.parse(json['expires_at']),
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
  final DateTime? watchedAt;
  final DateTime? expiresAt;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktEpisode? episode;
}
