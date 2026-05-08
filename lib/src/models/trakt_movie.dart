import '../core/trakt_date_utils.dart';
import 'trakt_ids.dart';

class TraktMovie {
  final String title;
  final int year;
  final TraktIds? ids;
  final String? tagline;
  final String? overview;
  final DateTime? released;
  final int? runtime;
  final String? country;
  final DateTime? updatedAt;
  final String? trailer;
  final String? homepage;
  final int? status;
  final double? rating;
  final int? votes;
  final int? commentCount;
  final String? language;
  final List<String>? availableTranslations;
  final List<String>? genres;
  final String? certification;

  const TraktMovie({
    required this.title,
    required this.year,
    this.ids,
    this.tagline,
    this.overview,
    this.released,
    this.runtime,
    this.country,
    this.updatedAt,
    this.trailer,
    this.homepage,
    this.status,
    this.rating,
    this.votes,
    this.commentCount,
    this.language,
    this.availableTranslations,
    this.genres,
    this.certification,
  });

  factory TraktMovie.fromJson(Map<String, dynamic> json) {
    return TraktMovie(
      title: json['title'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      released: TraktDateUtils.parse(json['released']),
      runtime: json['runtime'] as int?,
      country: json['country'] as String?,
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      trailer: json['trailer'] as String?,
      homepage: json['homepage'] as String?,
      status: json['status'] as int?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      language: json['language'] as String?,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      genres: (json['genres'] as List?)?.map((e) => e as String).toList(),
      certification: json['certification'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids?.toJson(),
      'tagline': tagline,
      'overview': overview,
      'released': released?.toIso8601String(),
      'runtime': runtime,
      'country': country,
      'updated_at': updatedAt?.toIso8601String(),
      'trailer': trailer,
      'homepage': homepage,
      'status': status,
      'rating': rating,
      'votes': votes,
      'comment_count': commentCount,
      'language': language,
      'available_translations': availableTranslations,
      'genres': genres,
      'certification': certification,
    };
  }
}
