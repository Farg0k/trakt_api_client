import '../core/trakt_date_utils.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';

class TraktMovieAlias {
  final String title;
  final String country;

  TraktMovieAlias({
    required this.title,
    required this.country,
  });

  factory TraktMovieAlias.fromJson(Map<String, dynamic> json) {
    return TraktMovieAlias(
      title: json['title'] as String,
      country: json['country'] as String,
    );
  }
}

class TraktMovieRelease {
  final String country;
  final DateTime? releaseDate;
  final String releaseType;
  final String note;
  final String certification;

  TraktMovieRelease({
    required this.country,
    this.releaseDate,
    required this.releaseType,
    required this.note,
    required this.certification,
  });

  factory TraktMovieRelease.fromJson(Map<String, dynamic> json) {
    return TraktMovieRelease(
      country: json['country'] as String,
      releaseDate: TraktDateUtils.parse(json['release_date']),
      releaseType: json['release_type'] as String? ?? '',
      note: json['note'] as String? ?? '',
      certification: json['certification'] as String? ?? '',
    );
  }
}

class TraktTranslation {
  final String title;
  final String overview;
  final String tagline;
  final String language;
  final String? country;

  TraktTranslation({
    required this.title,
    required this.overview,
    required this.tagline,
    required this.language,
    this.country,
  });

  factory TraktTranslation.fromJson(Map<String, dynamic> json) {
    return TraktTranslation(
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      language: json['language'] as String? ?? '',
      country: json['country'] as String?,
    );
  }
}

class TraktRating {
  final double rating;
  final int votes;
  final Map<String, int> distribution;

  TraktRating({
    required this.rating,
    required this.votes,
    required this.distribution,
  });

  factory TraktRating.fromJson(Map<String, dynamic> json) {
    return TraktRating(
      rating: (json['rating'] as num).toDouble(),
      votes: json['votes'] as int,
      distribution: Map<String, int>.from(json['distribution'] as Map),
    );
  }
}

class TraktMovieStats {
  final int watchers;
  final int plays;
  final int collectors;
  final int comments;
  final int lists;
  final int votes;

  TraktMovieStats({
    required this.watchers,
    required this.plays,
    required this.collectors,
    required this.comments,
    required this.lists,
    required this.votes,
  });

  factory TraktMovieStats.fromJson(Map<String, dynamic> json) {
    return TraktMovieStats(
      watchers: json['watchers'] as int,
      plays: json['plays'] as int,
      collectors: json['collectors'] as int,
      comments: json['comments'] as int,
      lists: json['lists'] as int,
      votes: json['votes'] as int,
    );
  }
}

class TraktBoxOfficeMovie {
  final int revenue;
  final TraktMovie movie;

  TraktBoxOfficeMovie({
    required this.revenue,
    required this.movie,
  });

  factory TraktBoxOfficeMovie.fromJson(Map<String, dynamic> json) {
    return TraktBoxOfficeMovie(
      revenue: json['revenue'] as int,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktMovieUpdate {
  final DateTime updatedAt;
  final TraktMovie movie;

  TraktMovieUpdate({
    required this.updatedAt,
    required this.movie,
  });

  factory TraktMovieUpdate.fromJson(Map<String, dynamic> json) {
    return TraktMovieUpdate(
      updatedAt: TraktDateUtils.parse(json['updated_at']) ?? DateTime.now(),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktCredits {
  final List<TraktCast>? cast;
  final Map<String, List<TraktCrew>>? crew;

  TraktCredits({this.cast, this.crew});

  factory TraktCredits.fromJson(Map<String, dynamic> json) {
    return TraktCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktCast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as Map?)?.map(
        (key, value) => MapEntry(
          key as String,
          (value as List)
              .map((e) => TraktCrew.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }
}

class TraktCast {
  final List<String> characters;
  final TraktPerson person;

  TraktCast({required this.characters, required this.person});

  factory TraktCast.fromJson(Map<String, dynamic> json) {
    return TraktCast(
      characters: List<String>.from(json['characters'] as List),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}

class TraktCrew {
  final String job;
  final TraktPerson person;

  TraktCrew({required this.job, required this.person});

  factory TraktCrew.fromJson(Map<String, dynamic> json) {
    return TraktCrew(
      job: json['job'] as String,
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}

class TraktTrendingMovie {
  final int watchers;
  final TraktMovie movie;

  TraktTrendingMovie({required this.watchers, required this.movie});

  factory TraktTrendingMovie.fromJson(Map<String, dynamic> json) {
    return TraktTrendingMovie(
      watchers: json['watchers'] as int,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktMostMovie {
  final int? watcherCount;
  final int? playCount;
  final int? collectedCount;
  final TraktMovie movie;

  TraktMostMovie({
    this.watcherCount,
    this.playCount,
    this.collectedCount,
    required this.movie,
  });

  factory TraktMostMovie.fromJson(Map<String, dynamic> json) {
    return TraktMostMovie(
      watcherCount: json['watcher_count'] as int?,
      playCount: json['play_count'] as int?,
      collectedCount: json['collected_count'] as int?,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktAnticipatedMovie {
  final int listCount;
  final TraktMovie movie;

  TraktAnticipatedMovie({required this.listCount, required this.movie});

  factory TraktAnticipatedMovie.fromJson(Map<String, dynamic> json) {
    return TraktAnticipatedMovie(
      listCount: json['list_count'] as int,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktFavoritedMovie {
  final int userCount;
  final TraktMovie movie;

  TraktFavoritedMovie({required this.userCount, required this.movie});

  factory TraktFavoritedMovie.fromJson(Map<String, dynamic> json) {
    return TraktFavoritedMovie(
      userCount: json['user_count'] as int,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktDeletedMovie {
  final DateTime deletedAt;
  final TraktMovie movie;

  TraktDeletedMovie({required this.deletedAt, required this.movie});

  factory TraktDeletedMovie.fromJson(Map<String, dynamic> json) {
    return TraktDeletedMovie(
      deletedAt: TraktDateUtils.parse(json['deleted_at']) ?? DateTime.now(),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}
