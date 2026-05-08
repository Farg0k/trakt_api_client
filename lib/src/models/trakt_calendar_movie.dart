import '../core/trakt_date_utils.dart';
import 'trakt_movie.dart';

class TraktCalendarMovie {
  final DateTime released;
  final TraktMovie movie;

  const TraktCalendarMovie({
    required this.released,
    required this.movie,
  });

  factory TraktCalendarMovie.fromJson(Map<String, dynamic> json) {
    return TraktCalendarMovie(
      released: TraktDateUtils.parse(json['released']) ?? DateTime.now(),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}
