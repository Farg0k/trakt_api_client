import 'trakt_movie.dart';
import 'trakt_show.dart';

class TraktWatchedMovie {
  final int plays;
  final DateTime lastWatchedAt;
  final DateTime lastUpdatedAt;
  final TraktMovie movie;

  const TraktWatchedMovie({
    required this.plays,
    required this.lastWatchedAt,
    required this.lastUpdatedAt,
    required this.movie,
  });

  factory TraktWatchedMovie.fromJson(Map<String, dynamic> json) {
    return TraktWatchedMovie(
      plays: json['plays'] as int,
      lastWatchedAt: DateTime.parse(json['last_watched_at'] as String),
      lastUpdatedAt: DateTime.parse(json['last_updated_at'] as String),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktWatchedShow {
  final int plays;
  final DateTime lastWatchedAt;
  final DateTime lastUpdatedAt;
  final TraktShow show;
  final List<TraktWatchedSeason>? seasons;

  const TraktWatchedShow({
    required this.plays,
    required this.lastWatchedAt,
    required this.lastUpdatedAt,
    required this.show,
    this.seasons,
  });

  factory TraktWatchedShow.fromJson(Map<String, dynamic> json) {
    return TraktWatchedShow(
      plays: json['plays'] as int,
      lastWatchedAt: DateTime.parse(json['last_watched_at'] as String),
      lastUpdatedAt: DateTime.parse(json['last_updated_at'] as String),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
      seasons: json['seasons'] != null
          ? (json['seasons'] as List)
              .map((e) => TraktWatchedSeason.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

class TraktWatchedSeason {
  final int number;
  final List<TraktWatchedEpisode> episodes;

  const TraktWatchedSeason({
    required this.number,
    required this.episodes,
  });

  factory TraktWatchedSeason.fromJson(Map<String, dynamic> json) {
    return TraktWatchedSeason(
      number: json['number'] as int,
      episodes: (json['episodes'] as List)
          .map((e) => TraktWatchedEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TraktWatchedEpisode {
  final int number;
  final int plays;
  final DateTime lastWatchedAt;

  const TraktWatchedEpisode({
    required this.number,
    required this.plays,
    required this.lastWatchedAt,
  });

  factory TraktWatchedEpisode.fromJson(Map<String, dynamic> json) {
    return TraktWatchedEpisode(
      number: json['number'] as int,
      plays: json['plays'] as int,
      lastWatchedAt: DateTime.parse(json['last_watched_at'] as String),
    );
  }
}
