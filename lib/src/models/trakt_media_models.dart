import 'trakt_ids.dart';
import 'trakt_person.dart';
import 'trakt_movie.dart';
import '../core/trakt_date_utils.dart';

class TraktRating {
  const TraktRating({
    required this.rating,
    required this.votes,
    required this.distribution,
  });

  factory TraktRating.fromJson(Map<String, dynamic> json) {
    return TraktRating(
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      votes: json['votes'] as int? ?? 0,
      distribution: Map<String, int>.from(json['distribution'] as Map? ?? {}),
    );
  }
  final double rating;
  final int votes;
  final Map<String, int> distribution;
}

class TraktCredits {
  const TraktCredits({this.cast, this.crew});

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
  final List<TraktCast>? cast;
  final Map<String, List<TraktCrew>>? crew;
}

class TraktCast {
  const TraktCast({this.characters, required this.person});

  factory TraktCast.fromJson(Map<String, dynamic> json) {
    return TraktCast(
      characters: (json['characters'] as List?)
          ?.map((e) => e as String)
          .toList(),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
  final List<String>? characters;
  final TraktPerson person;
}

class TraktCrew {
  const TraktCrew({required this.job, required this.person});

  factory TraktCrew.fromJson(Map<String, dynamic> json) {
    return TraktCrew(
      job: json['job'] as String? ?? '',
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
  final String job;
  final TraktPerson person;
}

class TraktMediaAlias {
  const TraktMediaAlias({required this.title, required this.country});

  factory TraktMediaAlias.fromJson(Map<String, dynamic> json) {
    return TraktMediaAlias(
      title: json['title'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
  final String title;
  final String country;
}

class TraktTranslation {
  const TraktTranslation({
    required this.title,
    this.overview,
    this.tagline,
    required this.language,
    this.country,
  });

  factory TraktTranslation.fromJson(Map<String, dynamic> json) {
    return TraktTranslation(
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String?,
      tagline: json['tagline'] as String?,
      language: json['language'] as String? ?? '',
      country: json['country'] as String?,
    );
  }
  final String title;
  final String? overview;
  final String? tagline;
  final String language;
  final String? country;
}

class TraktCertification {
  const TraktCertification({
    required this.name,
    required this.slug,
    required this.description,
  });

  factory TraktCertification.fromJson(Map<String, dynamic> json) {
    return TraktCertification(
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
  final String name;
  final String slug;
  final String description;
}

class TraktMediaCertification {
  const TraktMediaCertification({
    required this.certification,
    required this.country,
  });

  factory TraktMediaCertification.fromJson(Map<String, dynamic> json) {
    return TraktMediaCertification(
      certification: json['certification'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
  final String certification;
  final String country;
}

class TraktCountry {
  const TraktCountry({required this.name, required this.code});

  factory TraktCountry.fromJson(Map<String, dynamic> json) {
    return TraktCountry(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
  final String name;
  final String code;
}

class TraktGenre {
  const TraktGenre({required this.name, required this.slug});

  factory TraktGenre.fromJson(Map<String, dynamic> json) {
    return TraktGenre(
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }
  final String name;
  final String slug;
}

class TraktLanguage {
  const TraktLanguage({required this.name, required this.code});

  factory TraktLanguage.fromJson(Map<String, dynamic> json) {
    return TraktLanguage(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
  final String name;
  final String code;
}

class TraktNetwork {
  const TraktNetwork({required this.name});
  factory TraktNetwork.fromJson(Map<String, dynamic> json) {
    return TraktNetwork(name: json['name'] as String? ?? '');
  }
  final String name;
}

class TraktStudio {
  const TraktStudio({required this.name, this.country, this.ids});

  factory TraktStudio.fromJson(Map<String, dynamic> json) {
    return TraktStudio(
      name: json['name'] as String? ?? '',
      country: json['country'] as String?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
    );
  }
  final String name;
  final String? country;
  final TraktIds? ids;
}

class TraktMovieRelease {
  const TraktMovieRelease({
    required this.country,
    this.releaseDate,
    required this.releaseType,
    required this.note,
    required this.certification,
  });

  factory TraktMovieRelease.fromJson(Map<String, dynamic> json) {
    return TraktMovieRelease(
      country: json['country'] as String? ?? '',
      releaseDate: TraktDateUtils.parse(json['release_date']),
      releaseType: json['release_type'] as String? ?? '',
      note: json['note'] as String? ?? '',
      certification: json['certification'] as String? ?? '',
    );
  }
  final String country;
  final DateTime? releaseDate;
  final String releaseType;
  final String note;
  final String certification;
}

class TraktBoxOfficeMovie {
  const TraktBoxOfficeMovie({required this.revenue, required this.movie});

  factory TraktBoxOfficeMovie.fromJson(Map<String, dynamic> json) {
    return TraktBoxOfficeMovie(
      revenue: json['revenue'] as int? ?? 0,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
  final int revenue;
  final TraktMovie movie;
}
