import '../core/trakt_date_utils.dart';
import 'trakt_ids.dart';

class TraktEpisode {
  const TraktEpisode({
    required this.season,
    required this.number,
    required this.title,
    this.ids,
    this.numberAbs,
    this.overview,
    this.firstAired,
    this.updatedAt,
    this.rating,
    this.votes,
    this.commentCount,
    this.availableTranslations,
    this.runtime,
  });

  factory TraktEpisode.fromJson(Map<String, dynamic> json) {
    return TraktEpisode(
      season: json['season'] as int? ?? 0,
      number: json['number'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      numberAbs: json['number_abs'] as int?,
      overview: json['overview'] as String?,
      firstAired: TraktDateUtils.parse(json['first_aired']),
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      runtime: json['runtime'] as int?,
    );
  }
  final int season;
  final int number;
  final String title;
  final TraktIds? ids;
  final int? numberAbs;
  final String? overview;
  final DateTime? firstAired;
  final DateTime? updatedAt;
  final double? rating;
  final int? votes;
  final int? commentCount;
  final List<String>? availableTranslations;
  final int? runtime;

  Map<String, dynamic> toJson() {
    return {
      'season': season,
      'number': number,
      'title': title,
      'ids': ids?.toJson(),
      'number_abs': numberAbs,
      'overview': overview,
      'first_aired': firstAired?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'rating': rating,
      'votes': votes,
      'comment_count': commentCount,
      'available_translations': availableTranslations,
      'runtime': runtime,
    };
  }
}
