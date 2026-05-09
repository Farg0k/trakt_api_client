import 'trakt_episode.dart';
import 'trakt_list.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_show.dart';

class TraktSearchResult {
  const TraktSearchResult({
    required this.type,
    this.score,
    this.movie,
    this.show,
    this.episode,
    this.person,
    this.list,
  });

  factory TraktSearchResult.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktSearchResult(
      type: type,
      score: (json['score'] as num?)?.toDouble(),
      movie: type == 'movie' && json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: type == 'show' && json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
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
  final double? score;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktEpisode? episode;
  final TraktPerson? person;
  final TraktList? list;

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (score != null) 'score': score,
      if (movie != null) 'movie': movie!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
      if (person != null) 'person': person!.toJson(),
      if (list != null) 'list': list!.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}
