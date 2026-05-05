import 'trakt_ids.dart';

class TraktEpisode {
  final int? season;
  final int? number;
  final String? title;
  final TraktIds? ids;
  final int? numberAbs;
  final String? overview;
  final double? rating;
  final int? votes;
  final int? commentCount;
  final DateTime? firstAired;
  final DateTime? updatedAt;
  final List<String>? availableTranslations;
  final int? runtime;

  const TraktEpisode({
    this.season,
    this.number,
    this.title,
    this.ids,
    this.numberAbs,
    this.overview,
    this.rating,
    this.votes,
    this.commentCount,
    this.firstAired,
    this.updatedAt,
    this.availableTranslations,
    this.runtime,
  });

  factory TraktEpisode.fromJson(Map<String, dynamic> json) {
    return TraktEpisode(
      season: json['season'] as int?,
      number: json['number'] as int?,
      title: json['title'] as String?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      numberAbs: json['number_abs'] as int?,
      overview: json['overview'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      firstAired: json['first_aired'] != null
          ? DateTime.tryParse(json['first_aired'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      runtime: json['runtime'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'season': season,
      'number': number,
      'title': title,
      'ids': ids?.toJson(),
      'number_abs': numberAbs,
      'overview': overview,
      'rating': rating,
      'votes': votes,
      'comment_count': commentCount,
      'first_aired': firstAired?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'available_translations': availableTranslations,
      'runtime': runtime,
    };
  }
}
