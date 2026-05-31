import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_season.dart';
import 'trakt_show.dart';
import 'trakt_list.dart';

/// A universal container for any Trakt media object.
///
/// Used to avoid duplication in search results, list items, sync items, etc.
class TraktMediaEntity {
  /// Creates a new [TraktMediaEntity] instance.
  const TraktMediaEntity({
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
    this.person,
    this.list,
  });

  /// Creates a [TraktMediaEntity] from a JSON map.
  factory TraktMediaEntity.fromJson(Map<String, dynamic> json) {
    return TraktMediaEntity(
      type: json['type'] as String,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
      person: json['person'] != null
          ? TraktPerson.fromJson(json['person'] as Map<String, dynamic>)
          : null,
      list: json['list'] != null
          ? TraktList.fromJson(json['list'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Type of the media object (movie, show, episode, etc.).
  final String type;

  /// The movie object, if [type] is 'movie'.
  final TraktMovie? movie;

  /// The show object, if [type] is 'show'.
  final TraktShow? show;

  /// The season object, if [type] is 'season'.
  final TraktSeason? season;

  /// The episode object, if [type] is 'episode'.
  final TraktEpisode? episode;

  /// The person object, if [type] is 'person'.
  final TraktPerson? person;

  /// The list object, if [type] is 'list'.
  final TraktList? list;

  /// Converts this entity to a JSON map.
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
