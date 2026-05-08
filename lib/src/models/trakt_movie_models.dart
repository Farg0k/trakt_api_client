import '../core/trakt_date_utils.dart';
import 'trakt_movie.dart';

class TraktMovieRelease {
  final String country;
  final DateTime? releaseDate;
  final String releaseType;
  final String note;
  final String certification;

  const TraktMovieRelease({
    required this.country,
    this.releaseDate,
    required this.releaseType,
    required this.note,
    required this.certification,
  });

  factory TraktMovieRelease.fromJson(Map<String, dynamic> json) {
    return TraktMovieRelease(
      country: json['country'] as String? ?? '',
      releaseDate: TraktDateUtils.parse(json['release_date']),
      releaseType: json['release_type'] as String? ?? '',
      note: json['note'] as String? ?? '',
      certification: json['certification'] as String? ?? '',
    );
  }
}

class TraktBoxOfficeMovie {
  final int revenue;
  final TraktMovie movie;

  const TraktBoxOfficeMovie({
    required this.revenue,
    required this.movie,
  });

  factory TraktBoxOfficeMovie.fromJson(Map<String, dynamic> json) {
    return TraktBoxOfficeMovie(
      revenue: json['revenue'] as int? ?? 0,
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }
}
