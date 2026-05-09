import 'trakt_ids.dart';
import 'trakt_person.dart';
import 'trakt_movie.dart';
import '../core/trakt_date_utils.dart';

/// Rating information for any object.
class TraktRating {

  /// Creates a [TraktRating] from a JSON map.
  factory TraktRating.fromJson(Map<String, dynamic> json) {
    return TraktRating(
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      votes: json['votes'] as int? ?? 0,
      distribution: Map<String, int>.from(json['distribution'] as Map? ?? {}),
    );
  }
  /// Creates a new [TraktRating] instance.
  const TraktRating({
    required this.rating,
    required this.votes,
    required this.distribution,
  });

  /// Average rating value (0-10).
  final double rating;

  /// Total number of votes.
  final int votes;

  /// Rating distribution (1 to 10).
  final Map<String, int> distribution;
}

/// Cast and crew information.
class TraktCredits {

  /// Creates a [TraktCredits] from a JSON map.
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
  /// Creates a new [TraktCredits] instance.
  const TraktCredits({this.cast, this.crew});

  /// List of cast members.
  final List<TraktCast>? cast;

  /// Map of crew members grouped by department.
  final Map<String, List<TraktCrew>>? crew;
}

/// Represents a cast member.
class TraktCast {

  /// Creates a [TraktCast] from a JSON map.
  factory TraktCast.fromJson(Map<String, dynamic> json) {
    return TraktCast(
      characters:
          (json['characters'] as List?)?.map((e) => e as String).toList(),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
  /// Creates a new [TraktCast] instance.
  const TraktCast({this.characters, required this.person});

  /// Characters played by the person.
  final List<String>? characters;

  /// The person object.
  final TraktPerson person;
}

/// Represents a crew member.
class TraktCrew {

  /// Creates a [TraktCrew] from a JSON map.
  factory TraktCrew.fromJson(Map<String, dynamic> json) {
    return TraktCrew(
      job: json['job'] as String? ?? '',
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
  /// Creates a new [TraktCrew] instance.
  const TraktCrew({required this.job, required this.person});

  /// Job performed by the person.
  final String job;

  /// The person object.
  final TraktPerson person;
}

/// Title alias for a media object.
class TraktMediaAlias {

  /// Creates a [TraktMediaAlias] from a JSON map.
  factory TraktMediaAlias.fromJson(Map<String, dynamic> json) {
    return TraktMediaAlias(
      title: json['title'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
  /// Creates a new [TraktMediaAlias] instance.
  const TraktMediaAlias({
    required this.title,
    required this.country,
  });

  /// Title in the specific country.
  final String title;

  /// 2-character country code.
  final String country;
}

/// Translation for a media object.
class TraktTranslation {

  /// Creates a [TraktTranslation] from a JSON map.
  factory TraktTranslation.fromJson(Map<String, dynamic> json) {
    return TraktTranslation(
      title: json['title'] as String? ?? '',
      overview: json['overview'] as String?,
      tagline: json['tagline'] as String?,
      language: json['language'] as String? ?? '',
      country: json['country'] as String?,
    );
  }
  /// Creates a new [TraktTranslation] instance.
  const TraktTranslation({
    required this.title,
    this.overview,
    this.tagline,
    required this.language,
    this.country,
  });

  /// Translated title.
  final String title;

  /// Translated overview.
  final String? overview;

  /// Translated tagline.
  final String? tagline;

  /// Language code (e.g. 'en').
  final String language;

  /// 2-character country code.
  final String? country;
}

/// Content certification (e.g. PG-13).
class TraktCertification {

  /// Creates a [TraktCertification] from a JSON map.
  factory TraktCertification.fromJson(Map<String, dynamic> json) {
    return TraktCertification(
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
  /// Creates a new [TraktCertification] instance.
  const TraktCertification({
    required this.name,
    required this.slug,
    required this.description,
  });

  /// Name of the certification.
  final String name;

  /// Slug for the certification.
  final String slug;

  /// Description of the certification.
  final String description;
}

/// Media-specific certification.
class TraktMediaCertification {

  /// Creates a [TraktMediaCertification] from a JSON map.
  factory TraktMediaCertification.fromJson(Map<String, dynamic> json) {
    return TraktMediaCertification(
      certification: json['certification'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
  /// Creates a new [TraktMediaCertification] instance.
  const TraktMediaCertification({
    required this.certification,
    required this.country,
  });

  /// Certification code (e.g. 'PG-13').
  final String certification;

  /// 2-character country code.
  final String country;
}

/// Represents a country.
class TraktCountry {

  /// Creates a [TraktCountry] from a JSON map.
  factory TraktCountry.fromJson(Map<String, dynamic> json) {
    return TraktCountry(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
  /// Creates a new [TraktCountry] instance.
  const TraktCountry({required this.name, required this.code});

  /// Name of the country.
  final String name;

  /// 2-character country code.
  final String code;
}

/// Represents a media genre.
class TraktGenre {

  /// Creates a [TraktGenre] from a JSON map.
  factory TraktGenre.fromJson(Map<String, dynamic> json) {
    return TraktGenre(
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }
  /// Creates a new [TraktGenre] instance.
  const TraktGenre({required this.name, required this.slug});

  /// Name of the genre.
  final String name;

  /// URL slug for the genre.
  final String slug;
}

/// Represents a language.
class TraktLanguage {

  /// Creates a [TraktLanguage] from a JSON map.
  factory TraktLanguage.fromJson(Map<String, dynamic> json) {
    return TraktLanguage(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
  /// Creates a new [TraktLanguage] instance.
  const TraktLanguage({required this.name, required this.code});

  /// Name of the language.
  final String name;

  /// 2-character language code.
  final String code;
}

/// Represents a TV network.
class TraktNetwork {

  /// Creates a [TraktNetwork] from a JSON map.
  factory TraktNetwork.fromJson(Map<String, dynamic> json) {
    return TraktNetwork(name: json['name'] as String? ?? '');
  }
  /// Creates a new [TraktNetwork] instance.
  const TraktNetwork({required this.name});

  /// Name of the network.
  final String name;
}

/// Represents a production studio.
class TraktStudio {

  /// Creates a [TraktStudio] from a JSON map.
  factory TraktStudio.fromJson(Map<String, dynamic> json) {
    return TraktStudio(
      name: json['name'] as String? ?? '',
      country: json['country'] as String?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
    );
  }
  /// Creates a new [TraktStudio] instance.
  const TraktStudio({
    required this.name,
    this.country,
    this.ids,
  });

  /// Name of the studio.
  final String name;

  /// 2-character country code.
  final String? country;

  /// IDs for the studio.
  final TraktIds? ids;
}

/// Release information for a movie.
class TraktMovieRelease {

  /// Creates a [TraktMovieRelease] from a JSON map.
  factory TraktMovieRelease.fromJson(Map<String, dynamic> json) {
    return TraktMovieRelease(
      country: json['country'] as String? ?? '',
      releaseDate: TraktDateUtils.parse(json['release_date']),
      releaseType: json['release_type'] as String? ?? '',
      note: json['note'] as String? ?? '',
      certification: json['certification'] as String? ?? '',
    );
  }
  /// Creates a new [TraktMovieRelease] instance.
  const TraktMovieRelease({
    required this.country,
    this.releaseDate,
    required this.releaseType,
    required this.note,
    required this.certification,
  });

  /// 2-character country code.
  final String country;

  /// Date of the release.
  final DateTime? releaseDate;

  /// Type of release (e.g. 'theatrical').
  final String releaseType;

  /// Optional release notes.
  final String note;

  /// Certification for this specific release.
  final String certification;
}

/// Box office revenue information for a movie.
class TraktBoxOfficeMovie {

  /// Creates a [TraktBoxOfficeMovie] from a JSON map.
  factory TraktBoxOfficeMovie.fromJson(Map<String, dynamic> json) {
    return TraktBoxOfficeMovie(
      revenue: json['revenue'] as int? ?? 0,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
  /// Creates a new [TraktBoxOfficeMovie] instance.
  const TraktBoxOfficeMovie({
    required this.revenue,
    required this.movie,
  });

  /// Revenue in USD.
  final int revenue;

  /// The movie object.
  final TraktMovie movie;
}
