import '../core/trakt_date_utils.dart';
import 'trakt_episode.dart';
import 'trakt_ids.dart';

class TraktSeason {
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
    this.network,
    this.episodes,
  });

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
      network: json['network'] as String?,
      episodes: json['episodes'] != null
          ? (json['episodes'] as List)
                .map((e) => TraktEpisode.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }
  final int number;
  final TraktIds? ids;
  final double? rating;
  final int? votes;
  final int? episodeCount;
  final int? airedEpisodes;
  final String? title;
  final String? overview;
  final DateTime? firstAired;
  final String? network;
  final List<TraktEpisode>? episodes;

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'ids': ids?.toJson(),
      'rating': rating,
      'votes': votes,
      'episode_count': episodeCount,
      'aired_episodes': airedEpisodes,
      'title': title,
      'overview': overview,
      'first_aired': firstAired?.toIso8601String(),
      'network': network,
    };
  }
}
