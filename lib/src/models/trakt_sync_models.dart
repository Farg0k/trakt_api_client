import '../core/trakt_date_utils.dart';
import 'trakt_episode.dart';
import 'trakt_ids.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_season.dart';
import 'trakt_show.dart';

/// Request payload for synchronization.
class TraktSyncRequest {
  /// Creates a new [TraktSyncRequest] instance.
  TraktSyncRequest({
    this.movies,
    this.shows,
    this.seasons,
    this.episodes,
    this.people,
  });

  /// List of movies to sync.
  final List<TraktSyncMovie>? movies;

  /// List of shows to sync.
  final List<TraktSyncShow>? shows;

  /// List of seasons to sync.
  final List<TraktSyncSeason>? seasons;

  /// List of episodes to sync.
  final List<TraktSyncEpisode>? episodes;

  /// List of people to sync.
  final List<TraktSyncPerson>? people;

  /// Converts this request to a JSON map.
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

/// Movie entry for sync requests.
class TraktSyncMovie {
  /// Creates a new [TraktSyncMovie] instance.
  TraktSyncMovie({
    required this.movie,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
  });

  /// The movie object.
  final TraktMovie movie;

  /// When the movie was watched.
  final DateTime? watchedAt;

  /// When the movie was collected.
  final DateTime? collectedAt;

  /// Rating for the movie (1-10).
  final int? rating;

  /// When the movie was rated.
  final DateTime? ratedAt;

  /// Converts this movie to a JSON map.
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

/// Show entry for sync requests.
class TraktSyncShow {
  /// Creates a new [TraktSyncShow] instance.
  TraktSyncShow({
    required this.show,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
    this.seasons,
  });

  /// The show object.
  final TraktShow show;

  /// When the show was watched.
  final DateTime? watchedAt;

  /// When the show was collected.
  final DateTime? collectedAt;

  /// Rating for the show (1-10).
  final int? rating;

  /// When the show was rated.
  final DateTime? ratedAt;

  /// List of seasons to sync.
  final List<TraktSyncSeason>? seasons;

  /// Converts this show to a JSON map.
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

/// Season entry for sync requests.
class TraktSyncSeason {
  /// Creates a new [TraktSyncSeason] instance.
  const TraktSyncSeason({
    required this.number,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
    this.episodes,
  });

  /// Season number.
  final int number;

  /// When the season was watched.
  final DateTime? watchedAt;

  /// When the season was collected.
  final DateTime? collectedAt;

  /// Rating for the season (1-10).
  final int? rating;

  /// When the season was rated.
  final DateTime? ratedAt;

  /// List of episodes to sync.
  final List<TraktSyncEpisode>? episodes;

  /// Converts this season to a JSON map.
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

/// Episode entry for sync requests.
class TraktSyncEpisode {
  /// Creates a new [TraktSyncEpisode] instance.
  const TraktSyncEpisode({
    required this.number,
    this.watchedAt,
    this.collectedAt,
    this.rating,
    this.ratedAt,
  });

  /// Episode number.
  final int number;

  /// When the episode was watched.
  final DateTime? watchedAt;

  /// When the episode was collected.
  final DateTime? collectedAt;

  /// Rating for the episode (1-10).
  final int? rating;

  /// When the episode was rated.
  final DateTime? ratedAt;

  /// Converts this episode to a JSON map.
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

/// Person entry for sync requests.
class TraktSyncPerson {
  /// Creates a new [TraktSyncPerson] instance.
  const TraktSyncPerson({required this.person});

  /// The person object.
  final TraktPerson person;

  /// Converts this person to a JSON map.
  Map<String, dynamic> toJson() {
    return {'ids': person.ids?.toJson()};
  }
}

/// Response from a sync operation.
class TraktSyncResponse {
  /// Creates a new [TraktSyncResponse] instance.
  TraktSyncResponse({
    required this.added,
    required this.deleted,
    required this.existing,
    required this.notFound,
  });

  /// Creates a [TraktSyncResponse] from a JSON map.
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

  /// Number of items added.
  final TraktSyncCount added;

  /// Number of items deleted.
  final TraktSyncCount deleted;

  /// Number of existing items.
  final TraktSyncCount existing;

  /// List of items that were not found.
  final TraktSyncNotFound notFound;
}

/// Count of items in a sync operation.
class TraktSyncCount {
  /// Creates a new [TraktSyncCount] instance.
  TraktSyncCount({
    this.movies = 0,
    this.shows = 0,
    this.seasons = 0,
    this.episodes = 0,
    this.people = 0,
  });

  /// Creates a [TraktSyncCount] from a JSON map.
  factory TraktSyncCount.fromJson(Map<String, dynamic> json) {
    return TraktSyncCount(
      movies: json['movies'] as int? ?? 0,
      shows: json['shows'] as int? ?? 0,
      seasons: json['seasons'] as int? ?? 0,
      episodes: json['episodes'] as int? ?? 0,
      people: json['people'] as int? ?? 0,
    );
  }

  /// Number of movies.
  final int movies;

  /// Number of shows.
  final int shows;

  /// Number of seasons.
  final int seasons;

  /// Number of episodes.
  final int episodes;

  /// Number of people.
  final int people;
}

/// Items not found during a sync operation.
class TraktSyncNotFound {
  /// Creates a new [TraktSyncNotFound] instance.
  TraktSyncNotFound({
    required this.movies,
    required this.shows,
    required this.seasons,
    required this.episodes,
    required this.people,
  });

  /// Creates a [TraktSyncNotFound] from a JSON map.
  factory TraktSyncNotFound.fromJson(Map<String, dynamic> json) {
    return TraktSyncNotFound(
      movies:
          (json['movies'] as List?)
              ?.map((e) => TraktIds.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      shows:
          (json['shows'] as List?)
              ?.map((e) => TraktIds.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      seasons:
          (json['seasons'] as List?)
              ?.map((e) => TraktIds.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      episodes:
          (json['episodes'] as List?)
              ?.map((e) => TraktIds.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      people:
          (json['people'] as List?)
              ?.map((e) => TraktIds.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// List of movies not found.
  final List<TraktIds> movies;

  /// List of shows not found.
  final List<TraktIds> shows;

  /// List of seasons not found.
  final List<TraktIds> seasons;

  /// List of episodes not found.
  final List<TraktIds> episodes;

  /// List of people not found.
  final List<TraktIds> people;
}

/// Last activities for a user.
class TraktLastActivities {
  /// Creates a new [TraktLastActivities] instance.
  TraktLastActivities({
    this.all,
    required this.movies,
    required this.episodes,
    required this.shows,
    required this.seasons,
    required this.comments,
    required this.lists,
  });

  /// Creates a [TraktLastActivities] from a JSON map.
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

  /// Timestamp for all activities.
  final DateTime? all;

  /// Last movie activities.
  final TraktMediaActivities movies;

  /// Last episode activities.
  final TraktMediaActivities episodes;

  /// Last show activities.
  final TraktMediaActivities shows;

  /// Last season activities.
  final TraktMediaActivities seasons;

  /// Last comment activities.
  final TraktCommentActivities comments;

  /// Last list activities.
  final TraktListActivities lists;
}

/// Media-specific last activities.
class TraktMediaActivities {
  /// Creates a new [TraktMediaActivities] instance.
  TraktMediaActivities({
    this.watchedAt,
    this.collectedAt,
    this.ratedAt,
    this.watchlistedAt,
    this.recommendationsAt,
    this.commentedAt,
  });

  /// Creates a [TraktMediaActivities] from a JSON map.
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

  /// When last watched.
  final DateTime? watchedAt;

  /// When last collected.
  final DateTime? collectedAt;

  /// When last rated.
  final DateTime? ratedAt;

  /// When last added to watchlist.
  final DateTime? watchlistedAt;

  /// When last recommended.
  final DateTime? recommendationsAt;

  /// When last commented.
  final DateTime? commentedAt;
}

/// Comment-specific last activities.
class TraktCommentActivities {
  /// Creates a new [TraktCommentActivities] instance.
  TraktCommentActivities({this.likedAt});

  /// Creates a [TraktCommentActivities] from a JSON map.
  factory TraktCommentActivities.fromJson(Map<String, dynamic> json) {
    return TraktCommentActivities(
      likedAt: TraktDateUtils.parse(json['liked_at']),
    );
  }

  /// When a comment was last liked.
  final DateTime? likedAt;
}

/// List-specific last activities.
class TraktListActivities {
  /// Creates a new [TraktListActivities] instance.
  TraktListActivities({this.updatedAt, this.commentedAt, this.likedAt});

  /// Creates a [TraktListActivities] from a JSON map.
  factory TraktListActivities.fromJson(Map<String, dynamic> json) {
    return TraktListActivities(
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      commentedAt: TraktDateUtils.parse(json['commented_at']),
      likedAt: TraktDateUtils.parse(json['liked_at']),
    );
  }

  /// When a list was last updated.
  final DateTime? updatedAt;

  /// When a list was last commented on.
  final DateTime? commentedAt;

  /// When a list was last liked.
  final DateTime? likedAt;
}

/// Rating entry for sync requests.
class TraktSyncRating {
  /// Creates a new [TraktSyncRating] instance.
  TraktSyncRating({
    required this.rating,
    this.ratedAt,
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
  });

  /// Creates a [TraktSyncRating] from a JSON map.
  factory TraktSyncRating.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSyncRating(
      rating: json['rating'] as int,
      ratedAt: TraktDateUtils.parse(json['rated_at']),
      type: type,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Numerical rating (1-10).
  final int rating;

  /// When the item was rated.
  final DateTime? ratedAt;

  /// Type of the rated item.
  final String type;

  /// The movie object.
  final TraktMovie? movie;

  /// The show object.
  final TraktShow? show;

  /// The season object.
  final TraktSeason? season;

  /// The episode object.
  final TraktEpisode? episode;
}

/// Playback progress item for sync requests.
class TraktSyncPlayback {
  /// Creates a new [TraktSyncPlayback] instance.
  TraktSyncPlayback({
    required this.id,
    required this.progress,
    this.pausedAt,
    required this.type,
    this.movie,
    this.episode,
    this.show,
  });

  /// Creates a [TraktSyncPlayback] from a JSON map.
  factory TraktSyncPlayback.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSyncPlayback(
      id: json['id'] as int,
      progress: (json['progress'] as num).toDouble(),
      pausedAt: TraktDateUtils.parse(json['paused_at']),
      type: type,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Unique ID of the playback item.
  final int id;

  /// Progress percentage (0-100).
  final double progress;

  /// When playback was paused.
  final DateTime? pausedAt;

  /// Type of the item.
  final String type;

  /// The movie object.
  final TraktMovie? movie;

  /// The episode object.
  final TraktEpisode? episode;

  /// The show object.
  final TraktShow? show;
}

/// History entry for sync requests.
class TraktSyncHistory {
  /// Creates a new [TraktSyncHistory] instance.
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

  /// Creates a [TraktSyncHistory] from a JSON map.
  factory TraktSyncHistory.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSyncHistory(
      id: json['id'] as int,
      watchedAt: TraktDateUtils.parse(json['watched_at']),
      action: json['action'] as String,
      type: type,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Unique ID of the history entry.
  final int id;

  /// When the item was watched.
  final DateTime? watchedAt;

  /// Action performed (e.g. watch, checkin).
  final String action;

  /// Type of the item.
  final String type;

  /// The movie object.
  final TraktMovie? movie;

  /// The show object.
  final TraktShow? show;

  /// The season object.
  final TraktSeason? season;

  /// The episode object.
  final TraktEpisode? episode;

  @override
  String toString() {
    return '''TraktSyncHistory{
      id: $id, 
      watchedAt: $watchedAt, 
      action: $action, 
      type: $type, 
      movie: $movie, 
      show: $show, 
      season: $season, 
      episode: $episode
    }''';
  }
}
