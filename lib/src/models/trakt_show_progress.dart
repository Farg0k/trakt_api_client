import 'trakt_episode.dart';
import '../core/trakt_date_utils.dart';

/// Progress information for a TV show.
class TraktShowProgress {
  /// Creates a [TraktShowProgress] from a JSON map.
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

  /// Creates a new [TraktShowProgress] instance.
  const TraktShowProgress({
    required this.aired,
    required this.completed,
    this.lastWatchedAt,
    this.lastCollectedAt,
    required this.seasons,
    this.nextEpisode,
    this.lastEpisode,
  });

  /// Number of aired episodes.
  final int aired;

  /// Number of completed episodes.
  final int completed;

  /// When the last episode was watched.
  final DateTime? lastWatchedAt;

  /// When the last episode was collected.
  final DateTime? lastCollectedAt;

  /// Progress by season.
  final List<TraktSeasonProgress> seasons;

  /// The next episode to air.
  final TraktEpisode? nextEpisode;

  /// The last episode to air.
  final TraktEpisode? lastEpisode;

  @override
  String toString() {
    return '''TraktShowProgress{
      aired: $aired, 
      completed: $completed, 
      lastWatchedAt: $lastWatchedAt, 
      lastCollectedAt: $lastCollectedAt, 
      seasons: $seasons, 
      nextEpisode: $nextEpisode, 
      lastEpisode: $lastEpisode
    }''';
  }
}

/// Progress information for a single season.
class TraktSeasonProgress {
  /// Creates a [TraktSeasonProgress] from a JSON map.
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

  /// Creates a new [TraktSeasonProgress] instance.
  const TraktSeasonProgress({
    required this.number,
    required this.aired,
    required this.completed,
    this.title,
    required this.episodes,
  });

  /// Season number.
  final int number;

  /// Number of aired episodes in this season.
  final int aired;

  /// Number of completed episodes in this season.
  final int completed;

  /// Title of the season.
  final String? title;

  /// Progress by episode.
  final List<TraktEpisodeProgress> episodes;

  @override
  String toString() {
    return '''TraktSeasonProgress{
      number: $number, 
      aired: $aired, 
      completed: $completed, 
      title: $title, 
      episodes: $episodes
    }''';
  }
}

/// Progress information for a single episode.
class TraktEpisodeProgress {
  /// Creates a [TraktEpisodeProgress] from a JSON map.
  factory TraktEpisodeProgress.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeProgress(
      number: json['number'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      collectedAt: TraktDateUtils.parse(json['collected_at']),
    );
  }

  /// Creates a new [TraktEpisodeProgress] instance.
  const TraktEpisodeProgress({
    required this.number,
    required this.completed,
    this.watchedAt,
    this.collectedAt,
  });

  /// Episode number.
  final int number;

  /// Whether the episode is completed.
  final bool completed;

  /// When the episode was watched.
  final DateTime? watchedAt;

  /// When the episode was collected.
  final DateTime? collectedAt;

  @override
  String toString() {
    return '''TraktEpisodeProgress{
      number: $number, 
      completed: $completed, 
      watchedAt: $watchedAt, 
      collectedAt: $collectedAt
    }''';
  }
}
