import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_show.dart';

class TraktCheckinRequest {
  final TraktMovie? movie;
  final TraktEpisode? episode;
  final TraktShow? show;
  final String? message;
  final String? appVersion;
  final String? appDate;

  const TraktCheckinRequest({
    this.movie,
    this.episode,
    this.show,
    this.message,
    this.appVersion,
    this.appDate,
  });

  Map<String, dynamic> toJson() {
    return {
      if (movie != null) 'movie': movie!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (message != null) 'message': message,
      if (appVersion != null) 'app_version': appVersion,
      if (appDate != null) 'app_date': appDate,
    };
  }
}

class TraktCheckinResponse {
  final DateTime? watchedAt;
  final DateTime? expiresAt;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktEpisode? episode;

  const TraktCheckinResponse({
    this.watchedAt,
    this.expiresAt,
    this.movie,
    this.show,
    this.episode,
  });

  factory TraktCheckinResponse.fromJson(Map<String, dynamic> json) {
    return TraktCheckinResponse(
      watchedAt: json['watched_at'] != null
          ? DateTime.tryParse(json['watched_at'] as String)
          : null,
      expiresAt: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'] as String)
          : null,
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
