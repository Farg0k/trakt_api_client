import 'trakt_ids.dart';

class TraktMovie {
  final String? title;
  final int? year;
  final TraktIds? ids;
  final String? tagline;
  final String? overview;
  final double? rating;
  final int? votes;
  final String? certification;
  final DateTime? released;
  final int? runtime;
  final String? country;
  final String? trailer;
  final String? homepage;
  final String? status;
  final int? commentCount;
  final DateTime? updatedAt;
  final String? language;
  final List<String>? availableTranslations;
  final List<String>? genres;

  const TraktMovie({
    this.title,
    this.year,
    this.ids,
    this.tagline,
    this.overview,
    this.rating,
    this.votes,
    this.certification,
    this.released,
    this.runtime,
    this.country,
    this.trailer,
    this.homepage,
    this.status,
    this.commentCount,
    this.updatedAt,
    this.language,
    this.availableTranslations,
    this.genres,
  });

  factory TraktMovie.fromJson(Map<String, dynamic> json) {
    return TraktMovie(
      title: json['title'] as String?,
      year: json['year'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      certification: json['certification'] as String?,
      released: json['released'] != null
          ? DateTime.tryParse(json['released'] as String)
          : null,
      runtime: json['runtime'] as int?,
      country: json['country'] as String?,
      trailer: json['trailer'] as String?,
      homepage: json['homepage'] as String?,
      status: json['status'] as String?,
      commentCount: json['comment_count'] as int?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      language: json['language'] as String?,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      genres: (json['genres'] as List?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids?.toJson(),
      'tagline': tagline,
      'overview': overview,
      'rating': rating,
      'votes': votes,
      'certification': certification,
      'released': released?.toIso8601String(),
      'runtime': runtime,
      'country': country,
      'trailer': trailer,
      'homepage': homepage,
      'status': status,
      'comment_count': commentCount,
      'updated_at': updatedAt?.toIso8601String(),
      'language': language,
      'available_translations': availableTranslations,
      'genres': genres,
    };
  }
}
