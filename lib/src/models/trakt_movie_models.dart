import 'trakt_movie.dart';
import 'trakt_person.dart';

class TraktMovieAlias {
  final String title;
  final String country;

  const TraktMovieAlias({
    required this.title,
    required this.country,
  });

  factory TraktMovieAlias.fromJson(Map<String, dynamic> json) {
    return TraktMovieAlias(
      title: json['title'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'country': country,
    };
  }
}

class TraktMovieRelease {
  final String country;
  final DateTime date;
  final String certification;
  final String releaseType;
  final String note;

  const TraktMovieRelease({
    required this.country,
    required this.date,
    required this.certification,
    required this.releaseType,
    required this.note,
  });

  factory TraktMovieRelease.fromJson(Map<String, dynamic> json) {
    return TraktMovieRelease(
      country: json['country'] as String,
      date: DateTime.parse(json['release_date'] as String),
      certification: json['certification'] as String,
      releaseType: json['release_type'] as String,
      note: json['note'] as String? ?? '',
    );
  }
}

class TraktTranslation {
  final String title;
  final String overview;
  final String tagline;
  final String language;

  const TraktTranslation({
    required this.title,
    required this.overview,
    required this.tagline,
    required this.language,
  });

  factory TraktTranslation.fromJson(Map<String, dynamic> json) {
    return TraktTranslation(
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      language: json['language'] as String,
    );
  }
}

class TraktRating {
  final double rating;
  final int votes;
  final Map<String, int> distribution;

  const TraktRating({
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

  const TraktMovieStats({
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

  const TraktBoxOfficeMovie({
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

  const TraktMovieUpdate({
    required this.updatedAt,
    required this.movie,
  });

  factory TraktMovieUpdate.fromJson(Map<String, dynamic> json) {
    return TraktMovieUpdate(
      updatedAt: DateTime.parse(json['updated_at'] as String),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktCredits {
  final List<TraktCast>? cast;
  final Map<String, List<TraktCrew>>? crew;

  const TraktCredits({this.cast, this.crew});

  factory TraktCredits.fromJson(Map<String, dynamic> json) {
    return TraktCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktCast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
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

  const TraktCast({required this.characters, required this.person});

  factory TraktCast.fromJson(Map<String, dynamic> json) {
    return TraktCast(
      characters: (json['characters'] as List).map((e) => e as String).toList(),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}

class TraktCrew {
  final String job;
  final TraktPerson person;

  const TraktCrew({required this.job, required this.person});

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

  const TraktTrendingMovie({required this.watchers, required this.movie});

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

  const TraktMostMovie({
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

  const TraktAnticipatedMovie({required this.listCount, required this.movie});

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

  const TraktFavoritedMovie({required this.userCount, required this.movie});

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

  const TraktDeletedMovie({required this.deletedAt, required this.movie});

  factory TraktDeletedMovie.fromJson(Map<String, dynamic> json) {
    return TraktDeletedMovie(
      deletedAt: DateTime.parse(json['deleted_at'] as String),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}
