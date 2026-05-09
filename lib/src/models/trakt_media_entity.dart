import 'trakt_movie.dart';
import 'trakt_show.dart';
import 'trakt_season.dart';
import 'trakt_episode.dart';
import 'trakt_person.dart';
import 'trakt_list.dart';

/// A universal container for any Trakt media object.
///
/// Used to avoid duplication in search results, list items, sync items, etc.
class TraktMediaEntity {
  const TraktMediaEntity({
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
    this.person,
    this.list,
  });

  factory TraktMediaEntity.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktMediaEntity(
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
      list: type == 'list' && json['list'] != null
          ? TraktList.fromJson(json['list'] as Map<String, dynamic>)
          : null,
    );
  }
  final String type;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktSeason? season;
  final TraktEpisode? episode;
  final TraktPerson? person;
  final TraktList? list;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (movie != null) 'movie': movie!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (season != null) 'season': season!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
      if (person != null) 'person': person!.toJson(),
      if (list != null) 'list': list!.toJson(),
    };
  }
}
