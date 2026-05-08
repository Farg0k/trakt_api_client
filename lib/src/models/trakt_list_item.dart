import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_season.dart';
import 'trakt_show.dart';
import '../core/trakt_date_utils.dart';

class TraktListItem {
  final int? rank;
  final int id;
  final DateTime? listedAt;
  final String? notes;
  final String type;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktSeason? season;
  final TraktEpisode? episode;
  final TraktPerson? person;

  const TraktListItem({
    this.rank,
    required this.id,
    this.listedAt,
    this.notes,
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
    this.person,
  });

  factory TraktListItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktListItem(
      rank: json['rank'] as int?,
      id: json['id'] as int? ?? 0,
      listedAt: TraktDateUtils.parse(json['listed_at']),
      notes: json['notes'] as String?,
      type: type,
      movie: type == 'movie' && json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: type == 'show' && json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: type == 'season' && json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: type == 'episode' && json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
      person: type == 'person' && json['person'] != null
          ? TraktPerson.fromJson(json['person'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'id': id,
      'listed_at': listedAt?.toIso8601String(),
      'notes': notes,
      'type': type,
      if (movie != null) 'movie': movie!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (season != null) 'season': season!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
      if (person != null) 'person': person!.toJson(),
    };
  }
}
