import 'trakt_ids.dart';
import 'trakt_person.dart';

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
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      votes: json['votes'] as int? ?? 0,
      distribution: Map<String, int>.from(json['distribution'] as Map? ?? {}),
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
  final List<String>? characters;
  final TraktPerson person;

  const TraktCast({this.characters, required this.person});

  factory TraktCast.fromJson(Map<String, dynamic> json) {
    return TraktCast(
      characters: (json['characters'] as List?)?.map((e) => e as String).toList(),
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
      job: json['job'] as String? ?? '',
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
}

class TraktMediaAlias {
  final String title;
  final String country;

  const TraktMediaAlias({
    required this.title,
    required this.country,
  });

  factory TraktMediaAlias.fromJson(Map<String, dynamic> json) {
    return TraktMediaAlias(
      title: json['title'] as String? ?? '',
      country: json['country'] as String? ?? '',
    );
  }
}

class TraktTranslation {
  final String title;
  final String? overview;
  final String? tagline;
  final String language;
  final String? country;

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
}

class TraktCertification {
  final String name;
  final String slug;
  final String description;

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
}

class TraktMediaCertification {
  final String certification;
  final String country;

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
}

class TraktCountry {
  final String name;
  final String code;

  const TraktCountry({required this.name, required this.code});

  factory TraktCountry.fromJson(Map<String, dynamic> json) {
    return TraktCountry(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
}

class TraktGenre {
  final String name;
  final String slug;

  const TraktGenre({required this.name, required this.slug});

  factory TraktGenre.fromJson(Map<String, dynamic> json) {
    return TraktGenre(
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
    );
  }
}

class TraktLanguage {
  final String name;
  final String code;

  const TraktLanguage({required this.name, required this.code});

  factory TraktLanguage.fromJson(Map<String, dynamic> json) {
    return TraktLanguage(
      name: json['name'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }
}

class TraktNetwork {
  final String name;
  const TraktNetwork({required this.name});
  factory TraktNetwork.fromJson(Map<String, dynamic> json) {
    return TraktNetwork(name: json['name'] as String? ?? '');
  }
}

class TraktStudio {
  final String name;
  final String? country;
  final TraktIds? ids;

  const TraktStudio({
    required this.name,
    this.country,
    this.ids,
  });

  factory TraktStudio.fromJson(Map<String, dynamic> json) {
    return TraktStudio(
      name: json['name'] as String? ?? '',
      country: json['country'] as String?,
      ids: json['ids'] != null ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>) : null,
    );
  }
}
