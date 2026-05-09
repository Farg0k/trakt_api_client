import 'trakt_ids.dart';
import 'trakt_airs.dart';
import '../core/trakt_date_utils.dart';

/// Represents a TV show.
class TraktShow {

  /// Creates a [TraktShow] from a JSON map.
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
      homepage: json['homepage'] as String?,
      trailer: json['trailer'] as String?,
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
  /// Creates a new [TraktShow] instance.
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
    this.homepage,
    this.trailer,
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

  /// Title of the show.
  final String title;

  /// First aired year.
  final int? year;

  /// IDs for the show (Trakt, TMDB, etc.).
  final TraktIds? ids;

  /// Plot overview.
  final String? overview;

  /// When the show first aired.
  final DateTime? firstAired;

  /// Airing schedule info.
  final TraktAirs? airs;

  /// Runtime of an average episode in minutes.
  final int? runtime;

  /// Content certification (e.g. TV-MA).
  final String? certification;

  /// Network where the show airs.
  final String? network;

  /// Country of origin.
  final String? country;

  /// Official website URL.
  final String? homepage;

  /// Trailer URL.
  final String? trailer;

  /// Status of the show (returning series, ended, etc.).
  final String? status;

  /// Average rating.
  final double? rating;

  /// Total votes.
  final int? votes;

  /// Total comments.
  final int? commentCount;

  /// When the metadata was last updated.
  final DateTime? updatedAt;

  /// Language of origin.
  final String? language;

  /// Available translations.
  final List<String>? availableTranslations;

  /// List of genres.
  final List<String>? genres;

  /// Total aired episodes.
  final int? airedEpisodes;

  /// Converts this show to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      if (ids != null) 'ids': ids!.toJson(),
      'overview': overview,
      'first_aired': firstAired?.toIso8601String(),
      'airs': airs?.toJson(),
      'runtime': runtime,
      'certification': certification,
      'network': network,
      'country': country,
      'homepage': homepage,
      'trailer': trailer,
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
