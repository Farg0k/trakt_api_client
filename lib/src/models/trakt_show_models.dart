import 'trakt_show.dart';
import 'trakt_season.dart';
import 'trakt_episode.dart';

class TraktShowUpdate {
  final DateTime updatedAt;
  final TraktShow show;

  const TraktShowUpdate({
    required this.updatedAt,
    required this.show,
  });

  factory TraktShowUpdate.fromJson(Map<String, dynamic> json) {
    return TraktShowUpdate(
      updatedAt: DateTime.parse(json['updated_at'] as String),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

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
      updatedAt: DateTime.parse(json['updated_at'] as String),
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
      deletedAt: DateTime.parse(json['deleted_at'] as String),
      season: TraktSeason.fromJson(json['season'] as Map<String, dynamic>),
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

  const TraktShowAlias({
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

  const TraktTrendingShow({required this.watchers, required this.show});

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

  const TraktMostShow({
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

  const TraktAnticipatedShow({required this.listCount, required this.show});

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

  const TraktFavoritedShow({required this.userCount, required this.show});

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

  const TraktDeletedShow({required this.deletedAt, required this.show});

  factory TraktDeletedShow.fromJson(Map<String, dynamic> json) {
    return TraktDeletedShow(
      deletedAt: DateTime.parse(json['deleted_at'] as String),
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
      aired: json['aired'] as int,
      completed: json['completed'] as int,
      lastWatchedAt: json['last_watched_at'] != null
          ? DateTime.tryParse(json['last_watched_at'] as String)
          : null,
      lastCollectedAt: json['last_collected_at'] != null
          ? DateTime.tryParse(json['last_collected_at'] as String)
          : null,
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

  const TraktSeasonProgress({
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

  const TraktEpisodeProgress({
    required this.number,
    required this.completed,
    this.watchedAt,
    this.collectedAt,
  });

  factory TraktEpisodeProgress.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeProgress(
      number: json['number'] as int,
      completed: json['completed'] as bool,
      watchedAt: json['watched_at'] != null
          ? DateTime.tryParse(json['watched_at'] as String)
          : null,
      collectedAt: json['collected_at'] != null
          ? DateTime.tryParse(json['collected_at'] as String)
          : null,
    );
  }
}
