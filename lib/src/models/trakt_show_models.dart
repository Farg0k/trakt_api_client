import '../core/trakt_date_utils.dart';
import 'trakt_show.dart';
import 'trakt_season.dart';
import 'trakt_episode.dart';

class TraktSeasonUpdate {
  final DateTime updatedAt;
  final TraktSeason season;
  final TraktShow show;

  const TraktSeasonUpdate({
    required this.updatedAt,
    required this.season,
    required this.show,
  });

  factory TraktSeasonUpdate.fromJson(Map<String, dynamic> json) {
    return TraktSeasonUpdate(
      updatedAt: TraktDateUtils.parse(json['updated_at']) ?? DateTime.now(),
      season: TraktSeason.fromJson(json['season'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktDeletedSeason {
  final DateTime deletedAt;
  final TraktSeason season;
  final TraktShow show;

  const TraktDeletedSeason({
    required this.deletedAt,
    required this.season,
    required this.show,
  });

  factory TraktDeletedSeason.fromJson(Map<String, dynamic> json) {
    return TraktDeletedSeason(
      deletedAt: TraktDateUtils.parse(json['deleted_at']) ?? DateTime.now(),
      season: TraktSeason.fromJson(json['season'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktEpisodeUpdate {
  final DateTime updatedAt;
  final TraktEpisode episode;
  final TraktShow show;

  const TraktEpisodeUpdate({
    required this.updatedAt,
    required this.episode,
    required this.show,
  });

  factory TraktEpisodeUpdate.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeUpdate(
      updatedAt: TraktDateUtils.parse(json['updated_at']) ?? DateTime.now(),
      episode: TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktDeletedEpisode {
  final DateTime deletedAt;
  final TraktEpisode episode;
  final TraktShow show;

  const TraktDeletedEpisode({
    required this.deletedAt,
    required this.episode,
    required this.show,
  });

  factory TraktDeletedEpisode.fromJson(Map<String, dynamic> json) {
    return TraktDeletedEpisode(
      deletedAt: TraktDateUtils.parse(json['deleted_at']) ?? DateTime.now(),
      episode: TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktShowStats {
  final int watchers;
  final int plays;
  final int collectors;
  final int collectedEpisodes;
  final int comments;
  final int lists;
  final int votes;

  const TraktShowStats({
    required this.watchers,
    required this.plays,
    required this.collectors,
    required this.collectedEpisodes,
    required this.comments,
    required this.lists,
    required this.votes,
  });

  factory TraktShowStats.fromJson(Map<String, dynamic> json) {
    return TraktShowStats(
      watchers: json['watchers'] as int? ?? 0,
      plays: json['plays'] as int? ?? 0,
      collectors: json['collectors'] as int? ?? 0,
      collectedEpisodes: json['collected_episodes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      lists: json['lists'] as int? ?? 0,
      votes: json['votes'] as int? ?? 0,
    );
  }
}

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
