import 'trakt_episode.dart';
import 'trakt_list.dart';
import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_show.dart';

/// Represents a result from a Trakt search.
class TraktSearchResult {
  /// Creates a new [TraktSearchResult] instance.
  const TraktSearchResult({
    required this.type,
    this.score,
    this.movie,
    this.show,
    this.episode,
    this.person,
    this.list,
  });

  /// Creates a [TraktSearchResult] from a JSON map.
  factory TraktSearchResult.fromJson(Map<String, dynamic> json) {
    return TraktSearchResult(
      type: json['type'] as String,
      score: (json['score'] as num?)?.toDouble(),
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
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

  /// The type of the search result.
  final String type;

  /// Relevance score.
  final double? score;

  /// Movie object, if [type] is 'movie'.
  final TraktMovie? movie;

  /// Show object, if [type] is 'show'.
  final TraktShow? show;

  /// Episode object, if [type] is 'episode'.
  final TraktEpisode? episode;

  /// Person object, if [type] is 'person'.
  final TraktPerson? person;

  /// List object, if [type] is 'list'.
  final TraktList? list;

  /// Converts this result to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'score': score,
      if (movie != null) 'movie': movie!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
      if (person != null) 'person': person!.toJson(),
      if (list != null) 'list': list!.toJson(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  String toString() {
    return '''TraktSearchResult{
      type: $type, 
      score: $score, 
      movie: $movie, 
      show: $show, 
      episode: $episode, 
      person: $person, 
      list: $list
    }''';
  }
}
