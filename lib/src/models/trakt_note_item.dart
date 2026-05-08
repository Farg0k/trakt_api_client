import 'trakt_episode.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_season.dart';
import 'trakt_show.dart';

class TraktNoteItem {
  final String type;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktSeason? season;
  final TraktEpisode? episode;
  final TraktPerson? person;

  const TraktNoteItem({
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
    this.person,
  });

  factory TraktNoteItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktNoteItem(
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
}
