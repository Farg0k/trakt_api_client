import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_show.dart';

class TraktPersonMovieCredits {
  final List<TraktPersonMovieCast>? cast;
  final Map<String, List<TraktPersonMovieCrew>>? crew;

  const TraktPersonMovieCredits({this.cast, this.crew});

  factory TraktPersonMovieCredits.fromJson(Map<String, dynamic> json) {
    return TraktPersonMovieCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktPersonMovieCast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => TraktPersonMovieCrew.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }
}

class TraktPersonMovieCast {
  final List<String> characters;
  final TraktMovie movie;

  const TraktPersonMovieCast({required this.characters, required this.movie});

  factory TraktPersonMovieCast.fromJson(Map<String, dynamic> json) {
    return TraktPersonMovieCast(
      characters: (json['characters'] as List).map((e) => e as String).toList(),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktPersonMovieCrew {
  final String job;
  final TraktMovie movie;

  const TraktPersonMovieCrew({required this.job, required this.movie});

  factory TraktPersonMovieCrew.fromJson(Map<String, dynamic> json) {
    return TraktPersonMovieCrew(
      job: json['job'] as String,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}

class TraktPersonShowCredits {
  final List<TraktPersonShowCast>? cast;
  final Map<String, List<TraktPersonShowCrew>>? crew;

  const TraktPersonShowCredits({this.cast, this.crew});

  factory TraktPersonShowCredits.fromJson(Map<String, dynamic> json) {
    return TraktPersonShowCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktPersonShowCast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => TraktPersonShowCrew.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      ),
    );
  }
}

class TraktPersonShowCast {
  final List<String> characters;
  final TraktShow show;

  const TraktPersonShowCast({required this.characters, required this.show});

  factory TraktPersonShowCast.fromJson(Map<String, dynamic> json) {
    return TraktPersonShowCast(
      characters: (json['characters'] as List).map((e) => e as String).toList(),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktPersonShowCrew {
  final String job;
  final TraktShow show;

  const TraktPersonShowCrew({required this.job, required this.show});

  factory TraktPersonShowCrew.fromJson(Map<String, dynamic> json) {
    return TraktPersonShowCrew(
      job: json['job'] as String,
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktPersonUpdate {
  final DateTime updatedAt;
  final TraktPerson person;

  const TraktPersonUpdate({required this.updatedAt, required this.person});

  factory TraktPersonUpdate.fromJson(Map<String, dynamic> json) {
    return TraktPersonUpdate(
      updatedAt: DateTime.parse(json['updated_at'] as String),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}

class TraktDeletedPerson {
  final DateTime deletedAt;
  final TraktPerson person;

  const TraktDeletedPerson({required this.deletedAt, required this.person});

  factory TraktDeletedPerson.fromJson(Map<String, dynamic> json) {
    return TraktDeletedPerson(
      deletedAt: DateTime.parse(json['deleted_at'] as String),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}
