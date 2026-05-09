import 'trakt_movie.dart';
import 'trakt_show.dart';

/// Represents a response to a checkin request.
class TraktCheckinResponse {

  /// Creates a new [TraktCheckinResponse] instance.
  const TraktCheckinResponse({
    this.watchedAt,
    this.sharing,
    this.movie,
    this.show,
  });

  /// Creates a [TraktCheckinResponse] from a JSON map.
  factory TraktCheckinResponse.fromJson(Map<String, dynamic> json) {
    return TraktCheckinResponse(
      watchedAt: json['watched_at'] != null
          ? DateTime.tryParse(json['watched_at'] as String)
          : null,
      sharing: json['sharing'] as Map<String, dynamic>?,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
    );
  }
  /// When the checkin airs.
  final DateTime? watchedAt;
  /// The sharing settings used for this checkin.
  final Map<String, dynamic>? sharing;
  /// The movie object, if checking into a movie.
  final TraktMovie? movie;
  /// The show object, if checking into an episode.
  final TraktShow? show;
}
