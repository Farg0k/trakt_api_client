import 'trakt_airs.dart';
import 'trakt_ids.dart';

class TraktShow {
  final String? title;
  final int? year;
  final TraktIds? ids;
  final String? overview;
  final double? rating;
  final int? votes;
  final String? certification;
  final String? network;
  final String? status;
  final DateTime? firstAired;
  final TraktAirs? airs;
  final int? runtime;
  final String? country;
  final String? trailer;
  final String? homepage;
  final int? commentCount;
  final DateTime? updatedAt;
  final String? language;
  final List<String>? availableTranslations;
  final List<String>? genres;
  final int? airedEpisodes;

  const TraktShow({
    this.title,
    this.year,
    this.ids,
    this.overview,
    this.rating,
    this.votes,
    this.certification,
    this.network,
    this.status,
    this.firstAired,
    this.airs,
    this.runtime,
    this.country,
    this.trailer,
    this.homepage,
    this.commentCount,
    this.updatedAt,
    this.language,
    this.availableTranslations,
    this.genres,
    this.airedEpisodes,
  });

  factory TraktShow.fromJson(Map<String, dynamic> json) {
    return TraktShow(
      title: json['title'] as String?,
      year: json['year'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      overview: json['overview'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      certification: json['certification'] as String?,
      network: json['network'] as String?,
      status: json['status'] as String?,
      firstAired: json['first_aired'] != null
          ? DateTime.tryParse(json['first_aired'] as String)
          : null,
      airs: json['airs'] != null
          ? TraktAirs.fromJson(json['airs'] as Map<String, dynamic>)
          : null,
      runtime: json['runtime'] as int?,
      country: json['country'] as String?,
      trailer: json['trailer'] as String?,
      homepage: json['homepage'] as String?,
      commentCount: json['comment_count'] as int?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      language: json['language'] as String?,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      genres: (json['genres'] as List?)?.map((e) => e as String).toList(),
      airedEpisodes: json['aired_episodes'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids?.toJson(),
      'overview': overview,
      'rating': rating,
      'votes': votes,
      'certification': certification,
      'network': network,
      'status': status,
      'first_aired': firstAired?.toIso8601String(),
      'airs': airs?.toJson(),
      'runtime': runtime,
      'country': country,
      'trailer': trailer,
      'homepage': homepage,
      'comment_count': commentCount,
      'updated_at': updatedAt?.toIso8601String(),
      'language': language,
      'available_translations': availableTranslations,
      'genres': genres,
      'aired_episodes': airedEpisodes,
    };
  }
}
