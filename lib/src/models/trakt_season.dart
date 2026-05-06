import 'trakt_episode.dart';
import 'trakt_ids.dart';

class TraktSeason {
  final int? number;
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

  const TraktSeason({
    this.number,
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
      number: json['number'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      episodeCount: json['episode_count'] as int?,
      airedEpisodes: json['aired_episodes'] as int?,
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      firstAired: json['first_aired'] != null
          ? DateTime.tryParse(json['first_aired'] as String)
          : null,
      network: json['network'] as String?,
      episodes: (json['episodes'] as List?)
          ?.map((e) => TraktEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

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
      if (episodes != null) 'episodes': episodes!.map((e) => e.toJson()).toList(),
    };
  }
}
