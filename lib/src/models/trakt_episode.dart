import 'trakt_ids.dart';

/// Represents a media episode (TV show).
class TraktEpisode {

  /// Creates a [TraktEpisode] from a JSON map.
  factory TraktEpisode.fromJson(Map<String, dynamic> json) {
    return TraktEpisode(
      title: json['title'] as String? ?? '',
      season: json['season'] as int? ?? 0,
      number: json['number'] as int? ?? 0,
      numberAbs: json['number_abs'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      firstAired: json['first_aired'] != null
          ? DateTime.tryParse(json['first_aired'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      availableTranslations: (json['available_translations'] as List?)
          ?.map((e) => e as String)
          .toList(),
      runtime: json['runtime'] as int?,
      overview: json['overview'] as String?,
    );
  }
  /// Creates a new [TraktEpisode] instance.
  const TraktEpisode({
    required this.title,
    required this.season,
    required this.number,
    this.numberAbs,
    this.ids,
    this.firstAired,
    this.updatedAt,
    this.rating,
    this.votes,
    this.commentCount,
    this.availableTranslations,
    this.runtime,
    this.overview,
  });

  /// Title of the episode.
  final String title;

  /// Season number.
  final int season;

  /// Episode number within the season.
  final int number;

  /// Episode number overall.
  final int? numberAbs;

  /// IDs for the episode (Trakt, TMDB, etc.).
  final TraktIds? ids;

  /// When the episode first aired.
  final DateTime? firstAired;

  /// When the metadata was last updated.
  final DateTime? updatedAt;

  /// Average rating.
  final double? rating;

  /// Total votes.
  final int? votes;

  /// Total comments.
  final int? commentCount;

  /// Available translations.
  final List<String>? availableTranslations;

  /// Runtime in minutes.
  final int? runtime;

  /// Plot overview.
  final String? overview;

  /// Converts this episode to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'season': season,
      'number': number,
      if (numberAbs != null) 'number_abs': numberAbs,
      if (ids != null) 'ids': ids!.toJson(),
      if (firstAired != null) 'first_aired': firstAired!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      if (rating != null) 'rating': rating,
      if (votes != null) 'votes': votes,
      if (commentCount != null) 'comment_count': commentCount,
      if (availableTranslations != null)
        'available_translations': availableTranslations,
      if (runtime != null) 'runtime': runtime,
      if (overview != null) 'overview': overview,
    };
  }
}
