import '../core/trakt_date_utils.dart';
import 'trakt_show.dart';
import 'trakt_season.dart';
import 'trakt_episode.dart';

class TraktShowUpdate {
  final DateTime updatedAt;
  final TraktShow show;

  TraktShowUpdate({
    required this.updatedAt,
    required this.show,
  });

  factory TraktShowUpdate.fromJson(Map<String, dynamic> json) {
    return TraktShowUpdate(
      updatedAt: TraktDateUtils.parse(json['updated_at']) ?? DateTime.now(),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktSeasonUpdate {
  final DateTime updatedAt;
  final TraktSeason season;
  final TraktShow show;

  TraktSeasonUpdate({
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

  TraktDeletedSeason({
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

  TraktEpisodeUpdate({
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

  TraktDeletedEpisode({
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

  TraktShowStats({
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
      watchers: json['watchers'] as int,
      plays: json['plays'] as int,
      collectors: json['collectors'] as int,
      collectedEpisodes: json['collected_episodes'] as int,
      comments: json['comments'] as int,
      lists: json['lists'] as int,
      votes: json['votes'] as int,
    );
  }
}

class TraktShowAlias {
  final String title;
  final String country;

  TraktShowAlias({
    required this.title,
    required this.country,
  });

  factory TraktShowAlias.fromJson(Map<String, dynamic> json) {
    return TraktShowAlias(
      title: json['title'] as String,
      country: json['country'] as String,
    );
  }
}

class TraktTrendingShow {
  final int watchers;
  final TraktShow show;

  TraktTrendingShow({required this.watchers, required this.show});

  factory TraktTrendingShow.fromJson(Map<String, dynamic> json) {
    return TraktTrendingShow(
      watchers: json['watchers'] as int,
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktMostShow {
  final int? watcherCount;
  final int? playCount;
  final int? collectedCount;
  final TraktShow show;

  TraktMostShow({
    this.watcherCount,
    this.playCount,
    this.collectedCount,
    required this.show,
  });

  factory TraktMostShow.fromJson(Map<String, dynamic> json) {
    return TraktMostShow(
      watcherCount: json['watcher_count'] as int?,
      playCount: json['play_count'] as int?,
      collectedCount: json['collected_count'] as int?,
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktAnticipatedShow {
  final int listCount;
  final TraktShow show;

  TraktAnticipatedShow({required this.listCount, required this.show});

  factory TraktAnticipatedShow.fromJson(Map<String, dynamic> json) {
    return TraktAnticipatedShow(
      listCount: json['list_count'] as int,
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktFavoritedShow {
  final int userCount;
  final TraktShow show;

  TraktFavoritedShow({required this.userCount, required this.show});

  factory TraktFavoritedShow.fromJson(Map<String, dynamic> json) {
    return TraktFavoritedShow(
      userCount: json['user_count'] as int,
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktDeletedShow {
  final DateTime deletedAt;
  final TraktShow show;

  TraktDeletedShow({required this.deletedAt, required this.show});

  factory TraktDeletedShow.fromJson(Map<String, dynamic> json) {
    return TraktDeletedShow(
      deletedAt: TraktDateUtils.parse(json['deleted_at']) ?? DateTime.now(),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
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

  TraktShowProgress({
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
      aired: json['aired'] as int,
      completed: json['completed'] as int,
      lastWatchedAt: TraktDateUtils.parse(json['last_watched_at']),
      lastCollectedAt: TraktDateUtils.parse(json['last_collected_at']),
      seasons: (json['seasons'] as List)
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

  TraktSeasonProgress({
    required this.number,
    required this.aired,
    required this.completed,
    this.title,
    required this.episodes,
  });

  factory TraktSeasonProgress.fromJson(Map<String, dynamic> json) {
    return TraktSeasonProgress(
      number: json['number'] as int,
      aired: json['aired'] as int,
      completed: json['completed'] as int,
      title: json['title'] as String?,
      episodes: (json['episodes'] as List)
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

  TraktEpisodeProgress({
    required this.number,
    required this.completed,
    this.watchedAt,
    this.collectedAt,
  });

  factory TraktEpisodeProgress.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeProgress(
      number: json['number'] as int,
      completed: json['completed'] as bool,
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      collectedAt: TraktDateUtils.parse(json['collected_at']),
    );
  }
}
