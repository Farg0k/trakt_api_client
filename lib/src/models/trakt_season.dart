import 'trakt_ids.dart';
import 'trakt_episode.dart';
import '../core/trakt_date_utils.dart';

/// Represents a season of a TV show.
class TraktSeason {
  /// Creates a [TraktSeason] from a JSON map.
  factory TraktSeason.fromJson(Map<String, dynamic> json) {
    return TraktSeason(
      number: json['number'] as int? ?? 0,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      episodeCount: json['episode_count'] as int?,
      airedEpisodes: json['aired_episodes'] as int?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      firstAired: TraktDateUtils.parse(json['first_aired']),
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      episodes: (json['episodes'] as List?)
          ?.map((e) => TraktEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Creates a new [TraktSeason] instance.
  const TraktSeason({
    required this.number,
    this.ids,
    this.rating,
    this.votes,
    this.episodeCount,
    this.airedEpisodes,
    this.title,
    this.overview,
    this.firstAired,
    this.updatedAt,
    this.episodes,
  });

  /// Season number (0 for specials).
  final int number;

  /// IDs for the season (Trakt, TMDB, etc.).
  final TraktIds? ids;

  /// Average rating.
  final double? rating;

  /// Total votes.
  final int? votes;

  /// Total episodes in this season.
  final int? episodeCount;

  /// Total aired episodes in this season.
  final int? airedEpisodes;

  /// Title of the season.
  final String? title;

  /// Plot overview.
  final String? overview;

  /// When the season first aired.
  final DateTime? firstAired;

  /// When the metadata was last updated.
  final DateTime? updatedAt;

  /// List of episodes in this season.
  final List<TraktEpisode>? episodes;

  /// Converts this season to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      if (ids != null) 'ids': ids!.toJson(),
      'rating': rating,
      'votes': votes,
      'episode_count': episodeCount,
      'aired_episodes': airedEpisodes,
      'title': title,
      'overview': overview,
      'first_aired': firstAired?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      if (episodes != null)
        'episodes': episodes!.map((e) => e.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return '''TraktSeason{
      number: $number, 
      ids: $ids, 
      rating: $rating, 
      votes: $votes, 
      episodeCount: $episodeCount, 
      airedEpisodes: $airedEpisodes, 
      title: $title, 
      overview: $overview, 
      firstAired: $firstAired, 
      updatedAt: $updatedAt, 
      episodes: $episodes
    }''';
  }
}
