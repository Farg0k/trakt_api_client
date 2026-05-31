import '../core/trakt_date_utils.dart';
import 'trakt_ids.dart';
import 'trakt_trailers.dart';

/// Represents a movie.
class TraktMovie {

  /// Creates a [TraktMovie] from a JSON map.
  factory TraktMovie.fromJson(Map<String, dynamic> json) {
    return TraktMovie(
      title: json['title'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      released: TraktDateUtils.parse(json['released']),
      runtime: json['runtime'] as int?,
      homepage: json['homepage'] as String?,
      trailers: json['trailers'] != null
          ? TraktMovieTrailers.fromJson(
              json['trailers'] as Map<String, dynamic>)
          : null,
      // backward compatibility: if trailers object not present, fall back to single trailer string
      trailer: json['trailer'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      commentCount: json['comment_count'] as int?,
      language: json['language'] as String?,
      availableTranslations: json['available_translations'] is List
          ? (json['available_translations'] as List).cast<String>()
          : null,
      genres: json['genres'] is List
          ? (json['genres'] as List).cast<String>()
          : null,
      certification: json['certification'] as String?,
    );
  }
  /// Creates a new [TraktMovie] instance.
  const TraktMovie({
    required this.title,
    required this.year,
    this.ids,
    this.tagline,
    this.overview,
    this.released,
    this.runtime,
    this.homepage,
    this.trailer,
    this.trailers,
    this.rating,
    this.votes,
    this.commentCount,
    this.language,
    this.availableTranslations,
    this.genres,
    this.certification,
  });

  /// Title of the movie.
  final String title;

  /// Release year.
  final int year;

  /// IDs for the movie (Trakt, TMDB, etc.).
  final TraktIds? ids;

  /// Tagline for the movie.
  final String? tagline;

  /// Plot overview.
  final String? overview;

  /// Release date.
  final DateTime? released;

  /// Runtime in minutes.
  final int? runtime;

  /// Official website URL.
  final String? homepage;

  /// Legacy single trailer URL (deprecated, use trailers).
  @Deprecated('Use trailers instead')
  final String? trailer;

  /// Collection of trailer URLs.
  final TraktMovieTrailers? trailers;

  /// Average rating.
  final double? rating;

  /// Total votes.
  final int? votes;

  /// Total comments.
  final int? commentCount;

  /// Original language.
  final String? language;

  /// Available translations.
  final List<String>? availableTranslations;

  /// List of genres.
  final List<String>? genres;

  /// Content certification (e.g. PG-13).
  final String? certification;

  /// Converts this movie to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      if (ids != null) 'ids': ids!.toJson(),
      'tagline': tagline,
      'overview': overview,
      'released': released?.toIso8601String(),
      'runtime': runtime,
      'homepage': homepage,
      if (trailer != null) 'trailer': trailer,
      if (trailers != null) 'trailers': trailers!.toJson(),
      'rating': rating,
      'votes': votes,
      'comment_count': commentCount,
      'language': language,
      'available_translations': availableTranslations,
      'genres': genres,
      'certification': certification,
    };
  }

  @override
  String toString() {
    return '''TraktMovie{
      title: $title, 
      year: $year, 
      ids: $ids, 
      tagline: $tagline, 
      overview: $overview, 
      released: $released, 
      runtime: $runtime, 
      homepage: $homepage, 
      trailer: $trailer, 
      trailers: $trailers, 
      rating: $rating, 
      votes: $votes, 
      commentCount: $commentCount, 
      language: $language,
       availableTranslations: $availableTranslations, 
       genres: $genres, 
       certification: $certification
     }''';
  }
}
