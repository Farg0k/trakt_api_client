import 'trakt_movie.dart';

/// Represents a movie entry in a calendar.
class TraktCalendarMovie {

  /// Creates a new [TraktCalendarMovie] instance.
  const TraktCalendarMovie({
    required this.released,
    required this.movie,
  });

  /// Creates a [TraktCalendarMovie] from a JSON map.
  factory TraktCalendarMovie.fromJson(Map<String, dynamic> json) {
    return TraktCalendarMovie(
      released: DateTime.parse(json['released'] as String),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
  /// Date when the movie is released/aired.
  final DateTime released;
  /// The movie object.
  final TraktMovie movie;
}
