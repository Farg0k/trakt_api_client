import 'trakt_movie.dart';

class TraktCalendarMovie {
  final DateTime? released;
  final TraktMovie movie;

  const TraktCalendarMovie({
    this.released,
    required this.movie,
  });

  factory TraktCalendarMovie.fromJson(Map<String, dynamic> json) {
    return TraktCalendarMovie(
      released: json['released'] != null
          ? DateTime.tryParse(json['released'] as String)
          : null,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'released': released?.toIso8601String().split('T')[0],
      'movie': movie.toJson(),
    };
  }
}
