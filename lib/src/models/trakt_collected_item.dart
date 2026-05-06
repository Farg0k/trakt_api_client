import 'trakt_movie.dart';
import 'trakt_show.dart';

class TraktCollectedMovie {
  final DateTime lastCollectedAt;
  final DateTime lastUpdatedAt;
  final TraktMovie movie;
  final Map<String, dynamic>? metadata;

  const TraktCollectedMovie({
    required this.lastCollectedAt,
    required this.lastUpdatedAt,
    required this.movie,
    this.metadata,
  });

  factory TraktCollectedMovie.fromJson(Map<String, dynamic> json) {
    return TraktCollectedMovie(
      lastCollectedAt: DateTime.parse(json['last_collected_at'] as String),
      lastUpdatedAt: DateTime.parse(json['last_updated_at'] as String),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}

class TraktCollectedShow {
  final DateTime lastCollectedAt;
  final DateTime lastUpdatedAt;
  final TraktShow show;
  final List<TraktCollectedSeason>? seasons;

  const TraktCollectedShow({
    required this.lastCollectedAt,
    required this.lastUpdatedAt,
    required this.show,
    this.seasons,
  });

  factory TraktCollectedShow.fromJson(Map<String, dynamic> json) {
    return TraktCollectedShow(
      lastCollectedAt: DateTime.parse(json['last_collected_at'] as String),
      lastUpdatedAt: DateTime.parse(json['last_updated_at'] as String),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
      seasons: json['seasons'] != null
          ? (json['seasons'] as List)
              .map((e) => TraktCollectedSeason.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }
}

class TraktCollectedSeason {
  final int number;
  final List<TraktCollectedEpisode> episodes;

  const TraktCollectedSeason({
    required this.number,
    required this.episodes,
  });

  factory TraktCollectedSeason.fromJson(Map<String, dynamic> json) {
    return TraktCollectedSeason(
      number: json['number'] as int,
      episodes: (json['episodes'] as List)
          .map((e) => TraktCollectedEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TraktCollectedEpisode {
  final int number;
  final DateTime collectedAt;
  final Map<String, dynamic>? metadata;

  const TraktCollectedEpisode({
    required this.number,
    required this.collectedAt,
    this.metadata,
  });

  factory TraktCollectedEpisode.fromJson(Map<String, dynamic> json) {
    return TraktCollectedEpisode(
      number: json['number'] as int,
      collectedAt: DateTime.parse(json['collected_at'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}
