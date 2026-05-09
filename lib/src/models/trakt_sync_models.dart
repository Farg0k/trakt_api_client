import '../core/trakt_date_utils.dart';
import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_season.dart';
import 'trakt_show.dart';

class TraktSyncRequest {
  TraktSyncRequest({
    this.movies,
    this.shows,
    this.seasons,
    this.episodes,
    this.people,
  });
  final List<TraktSyncMovie>? movies;
  final List<TraktSyncShow>? shows;
  final List<TraktSyncSeason>? seasons;
  final List<TraktSyncEpisode>? episodes;
  final List<TraktSyncPerson>? people;

  Map<String, dynamic> toJson() {
    return {
      if (movies != null) 'movies': movies!.map((e) => e.toJson()).toList(),
      if (shows != null) 'shows': shows!.map((e) => e.toJson()).toList(),
      if (seasons != null) 'seasons': seasons!.map((e) => e.toJson()).toList(),
      if (episodes != null)
        'episodes': episodes!.map((e) => e.toJson()).toList(),
      if (people != null) 'people': people!.map((e) => e.toJson()).toList(),
    };
  }
}

class TraktSyncMovie {
  TraktSyncMovie({
    required this.movie,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
  });
  final TraktMovie movie;
  final DateTime? watchedAt;
  final DateTime? collectedAt;
  final int? rating;
  final DateTime? ratedAt;

  Map<String, dynamic> toJson() {
    return {
      'ids': movie.ids?.toJson(),
      if (watchedAt != null)
        'watched_at': TraktDateUtils.formatFullDate(watchedAt!),
      if (collectedAt != null)
        'collected_at': TraktDateUtils.formatFullDate(collectedAt!),
      if (rating != null) 'rating': rating,
      if (ratedAt != null) 'rated_at': TraktDateUtils.formatFullDate(ratedAt!),
    };
  }
}

class TraktSyncShow {
  TraktSyncShow({
    required this.show,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
    this.seasons,
  });
  final TraktShow show;
  final DateTime? watchedAt;
  final DateTime? collectedAt;
  final int? rating;
  final DateTime? ratedAt;
  final List<TraktSyncSeason>? seasons;

  Map<String, dynamic> toJson() {
    return {
      'ids': show.ids?.toJson(),
      if (watchedAt != null)
        'watched_at': TraktDateUtils.formatFullDate(watchedAt!),
      if (collectedAt != null)
        'collected_at': TraktDateUtils.formatFullDate(collectedAt!),
      if (rating != null) 'rating': rating,
      if (ratedAt != null) 'rated_at': TraktDateUtils.formatFullDate(ratedAt!),
      if (seasons != null) 'seasons': seasons!.map((e) => e.toJson()).toList(),
    };
  }
}

class TraktSyncSeason {
  TraktSyncSeason({
    required this.number,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
    this.episodes,
  });
  final int number;
  final DateTime? watchedAt;
  final DateTime? collectedAt;
  final int? rating;
  final DateTime? ratedAt;
  final List<TraktSyncEpisode>? episodes;

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      if (watchedAt != null)
        'watched_at': TraktDateUtils.formatFullDate(watchedAt!),
      if (collectedAt != null)
        'collected_at': TraktDateUtils.formatFullDate(collectedAt!),
      if (rating != null) 'rating': rating,
      if (ratedAt != null) 'rated_at': TraktDateUtils.formatFullDate(ratedAt!),
      if (episodes != null)
        'episodes': episodes!.map((e) => e.toJson()).toList(),
    };
  }
}

class TraktSyncEpisode {
  TraktSyncEpisode({
    required this.number,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
  });
  final int number;
  final DateTime? watchedAt;
  final DateTime? collectedAt;
  final int? rating;
  final DateTime? ratedAt;

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      if (watchedAt != null)
        'watched_at': TraktDateUtils.formatFullDate(watchedAt!),
      if (collectedAt != null)
        'collected_at': TraktDateUtils.formatFullDate(collectedAt!),
      if (rating != null) 'rating': rating,
      if (ratedAt != null) 'rated_at': TraktDateUtils.formatFullDate(ratedAt!),
    };
  }
}

class TraktSyncPerson {
  TraktSyncPerson({required this.person});
  final TraktPerson person;

  Map<String, dynamic> toJson() {
    return {'ids': person.ids?.toJson()};
  }
}

class TraktSyncResponse {
  TraktSyncResponse({
    required this.added,
    required this.deleted,
    required this.existing,
    required this.notFound,
  });

  factory TraktSyncResponse.fromJson(Map<String, dynamic> json) {
    return TraktSyncResponse(
      added: TraktSyncCount.fromJson(json['added'] as Map<String, dynamic>),
      deleted: TraktSyncCount.fromJson(json['deleted'] as Map<String, dynamic>),
      existing: TraktSyncCount.fromJson(
        json['existing'] as Map<String, dynamic>,
      ),
      notFound: TraktSyncNotFound.fromJson(
        json['not_found'] as Map<String, dynamic>,
      ),
    );
  }
  final TraktSyncCount added;
  final TraktSyncCount deleted;
  final TraktSyncCount existing;
  final TraktSyncNotFound notFound;
}

class TraktSyncCount {
  TraktSyncCount({
    this.movies = 0,
    this.shows = 0,
    this.seasons = 0,
    this.episodes = 0,
    this.people = 0,
  });

  factory TraktSyncCount.fromJson(Map<String, dynamic> json) {
    return TraktSyncCount(
      movies: json['movies'] as int? ?? 0,
      shows: json['shows'] as int? ?? 0,
      seasons: json['seasons'] as int? ?? 0,
      episodes: json['episodes'] as int? ?? 0,
      people: json['people'] as int? ?? 0,
    );
  }
  final int movies;
  final int shows;
  final int seasons;
  final int episodes;
  final int people;
}

class TraktSyncNotFound {
  TraktSyncNotFound({
    required this.movies,
    required this.shows,
    required this.seasons,
    required this.episodes,
    required this.people,
  });

  factory TraktSyncNotFound.fromJson(Map<String, dynamic> json) {
    return TraktSyncNotFound(
      movies: List<Map<String, dynamic>>.from(json['movies'] as List? ?? []),
      shows: List<Map<String, dynamic>>.from(json['shows'] as List? ?? []),
      seasons: List<Map<String, dynamic>>.from(json['seasons'] as List? ?? []),
      episodes: List<Map<String, dynamic>>.from(
        json['episodes'] as List? ?? [],
      ),
      people: List<Map<String, dynamic>>.from(json['people'] as List? ?? []),
    );
  }
  final List<Map<String, dynamic>> movies;
  final List<Map<String, dynamic>> shows;
  final List<Map<String, dynamic>> seasons;
  final List<Map<String, dynamic>> episodes;
  final List<Map<String, dynamic>> people;
}

class TraktLastActivities {
  TraktLastActivities({
    this.all,
    required this.movies,
    required this.episodes,
    required this.shows,
    required this.seasons,
    required this.comments,
    required this.lists,
  });

  factory TraktLastActivities.fromJson(Map<String, dynamic> json) {
    return TraktLastActivities(
      all: TraktDateUtils.parse(json['all']),
      movies: TraktMediaActivities.fromJson(
        json['movies'] as Map<String, dynamic>,
      ),
      episodes: TraktMediaActivities.fromJson(
        json['episodes'] as Map<String, dynamic>,
      ),
      shows: TraktMediaActivities.fromJson(
        json['shows'] as Map<String, dynamic>,
      ),
      seasons: TraktMediaActivities.fromJson(
        json['seasons'] as Map<String, dynamic>,
      ),
      comments: TraktCommentActivities.fromJson(
        json['comments'] as Map<String, dynamic>,
      ),
      lists: TraktListActivities.fromJson(
        json['lists'] as Map<String, dynamic>,
      ),
    );
  }
  final DateTime? all;
  final TraktMediaActivities movies;
  final TraktMediaActivities episodes;
  final TraktMediaActivities shows;
  final TraktMediaActivities seasons;
  final TraktCommentActivities comments;
  final TraktListActivities lists;
}

class TraktMediaActivities {
  TraktMediaActivities({
    this.watchedAt,
    this.collectedAt,
    this.ratedAt,
    this.watchlistedAt,
    this.recommendationsAt,
    this.commentedAt,
  });

  factory TraktMediaActivities.fromJson(Map<String, dynamic> json) {
    return TraktMediaActivities(
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      collectedAt: TraktDateUtils.parse(json['collected_at']),
      ratedAt: TraktDateUtils.parse(json['rated_at']),
      watchlistedAt: TraktDateUtils.parse(json['watchlisted_at']),
      recommendationsAt: TraktDateUtils.parse(json['recommendations_at']),
      commentedAt: TraktDateUtils.parse(json['commented_at']),
    );
  }
  final DateTime? watchedAt;
  final DateTime? collectedAt;
  final DateTime? ratedAt;
  final DateTime? watchlistedAt;
  final DateTime? recommendationsAt;
  final DateTime? commentedAt;
}

class TraktCommentActivities {
  TraktCommentActivities({this.likedAt});

  factory TraktCommentActivities.fromJson(Map<String, dynamic> json) {
    return TraktCommentActivities(
      likedAt: TraktDateUtils.parse(json['liked_at']),
    );
  }
  final DateTime? likedAt;
}

class TraktListActivities {
  TraktListActivities({this.updatedAt, this.commentedAt, this.likedAt});

  factory TraktListActivities.fromJson(Map<String, dynamic> json) {
    return TraktListActivities(
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      commentedAt: TraktDateUtils.parse(json['commented_at']),
      likedAt: TraktDateUtils.parse(json['liked_at']),
    );
  }
  final DateTime? updatedAt;
  final DateTime? commentedAt;
  final DateTime? likedAt;
}

class TraktSyncRating {
  TraktSyncRating({
    required this.rating,
    this.ratedAt,
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
  });

  factory TraktSyncRating.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSyncRating(
      rating: json['rating'] as int,
      ratedAt: TraktDateUtils.parse(json['rated_at']),
      type: type,
      movie: type == 'movie' && json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: type == 'show' && json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: type == 'season' && json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: type == 'episode' && json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
    );
  }
  final int rating;
  final DateTime? ratedAt;
  final String type;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktSeason? season;
  final TraktEpisode? episode;
}

class TraktSyncPlayback {
  TraktSyncPlayback({
    required this.id,
    required this.progress,
    this.pausedAt,
    required this.type,
    this.movie,
    this.episode,
    this.show,
  });

  factory TraktSyncPlayback.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSyncPlayback(
      id: json['id'] as int,
      progress: (json['progress'] as num).toDouble(),
      pausedAt: TraktDateUtils.parse(json['paused_at']),
      type: type,
      movie: type == 'movie' && json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      episode: type == 'episode' && json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
      show: type == 'show' && json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
    );
  }
  final int id;
  final double progress;
  final DateTime? pausedAt;
  final String type;
  final TraktMovie? movie;
  final TraktEpisode? episode;
  final TraktShow? show;
}

class TraktSyncHistory {
  TraktSyncHistory({
    required this.id,
    this.watchedAt,
    required this.action,
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
  });

  factory TraktSyncHistory.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSyncHistory(
      id: json['id'] as int,
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      action: json['action'] as String,
      type: type,
      movie: type == 'movie' && json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: type == 'show' && json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: type == 'season' && json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: type == 'episode' && json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
    );
  }
  final int id;
  final DateTime? watchedAt;
  final String action;
  final String type;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktSeason? season;
  final TraktEpisode? episode;
}
