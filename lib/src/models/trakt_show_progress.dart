import 'trakt_episode.dart';
import '../core/trakt_date_utils.dart';

class TraktShowProgress {
  final int aired;
  final int completed;
  final DateTime? lastWatchedAt;
  final DateTime? lastCollectedAt;
  final List<TraktSeasonProgress> seasons;
  final TraktEpisode? nextEpisode;
  final TraktEpisode? lastEpisode;

  const TraktShowProgress({
    required this.aired,
    required this.completed,
    this.lastWatchedAt,
    this.lastCollectedAt,
    required this.seasons,
    this.nextEpisode,
    this.lastEpisode,
  });

  factory TraktShowProgress.fromJson(Map<String, dynamic> json) {
    return TraktShowProgress(
      aired: json['aired'] as int? ?? 0,
      completed: json['completed'] as int? ?? 0,
      lastWatchedAt: TraktDateUtils.parse(json['last_watched_at']),
      lastCollectedAt: TraktDateUtils.parse(json['last_collected_at']),
      seasons: (json['seasons'] as List? ?? [])
          .map((e) => TraktSeasonProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextEpisode: json['next_episode'] != null
          ? TraktEpisode.fromJson(json['next_episode'] as Map<String, dynamic>)
          : null,
      lastEpisode: json['last_episode'] != null
          ? TraktEpisode.fromJson(json['last_episode'] as Map<String, dynamic>)
          : null,
    );
  }
}

class TraktSeasonProgress {
  final int number;
  final int aired;
  final int completed;
  final String? title;
  final List<TraktEpisodeProgress> episodes;

  const TraktSeasonProgress({
    required this.number,
    required this.aired,
    required this.completed,
    this.title,
    required this.episodes,
  });

  factory TraktSeasonProgress.fromJson(Map<String, dynamic> json) {
    return TraktSeasonProgress(
      number: json['number'] as int? ?? 0,
      aired: json['aired'] as int? ?? 0,
      completed: json['completed'] as int? ?? 0,
      title: json['title'] as String?,
      episodes: (json['episodes'] as List? ?? [])
          .map((e) => TraktEpisodeProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class TraktEpisodeProgress {
  final int number;
  final bool completed;
  final DateTime? watchedAt;
  final DateTime? collectedAt;

  const TraktEpisodeProgress({
    required this.number,
    required this.completed,
    this.watchedAt,
    this.collectedAt,
  });

  factory TraktEpisodeProgress.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeProgress(
      number: json['number'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      collectedAt: TraktDateUtils.parse(json['collected_at']),
    );
  }
}
