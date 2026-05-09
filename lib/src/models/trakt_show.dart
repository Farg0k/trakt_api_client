import '../core/trakt_date_utils.dart';
import 'trakt_airs.dart';
import 'trakt_ids.dart';

class TraktShow {
  const TraktShow({
    required this.title,
    this.year,
    this.ids,
    this.overview,
    this.firstAired,
    this.airs,
    this.runtime,
    this.certification,
    this.network,
    this.country,
    this.trailer,
    this.homepage,
    this.status,
    this.rating,
    this.votes,
    this.commentCount,
    this.updatedAt,
    this.language,
    this.availableTranslations,
    this.genres,
    this.airedEpisodes,
  });

  factory TraktShow.fromJson(Map<String, dynamic> json) {
    return TraktShow(
      title: json['title'] as String? ?? '',
      year: json['year'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      overview: json['overview'] as String?,
      firstAired: TraktDateUtils.parse(json['first_aired']),
      airs: json['airs'] != null
          ? TraktAirs.fromJson(json['airs'] as Map<String, dynamic>)
          : null,
      runtime: json['runtime'] as int?,
      certification: json['certification'] as String?,
      network: json['network'] as String?,
      country: json['country'] as String?,
      trailer: json['trailer'] as String?,
      homepage: json['homepage'] as String?,
      status: json['status'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      language: json['language'] as String?,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      genres: (json['genres'] as List?)?.map((e) => e as String).toList(),
      airedEpisodes: json['aired_episodes'] as int?,
    );
  }
  final String title;
  final int? year;
  final TraktIds? ids;
  final String? overview;
  final DateTime? firstAired;
  final TraktAirs? airs;
  final int? runtime;
  final String? certification;
  final String? network;
  final String? country;
  final String? trailer;
  final String? homepage;
  final String? status;
  final double? rating;
  final int? votes;
  final int? commentCount;
  final DateTime? updatedAt;
  final String? language;
  final List<String>? availableTranslations;
  final List<String>? genres;
  final int? airedEpisodes;

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids?.toJson(),
      'overview': overview,
      'first_aired': firstAired?.toIso8601String(),
      'airs': airs?.toJson(),
      'runtime': runtime,
      'certification': certification,
      'network': network,
      'country': country,
      'trailer': trailer,
      'homepage': homepage,
      'status': status,
      'rating': rating,
      'votes': votes,
      'comment_count': commentCount,
      'updated_at': updatedAt?.toIso8601String(),
      'language': language,
      'available_translations': availableTranslations,
      'genres': genres,
      'aired_episodes': airedEpisodes,
    };
  }
}
