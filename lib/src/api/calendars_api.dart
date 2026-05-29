import '../core/trakt_date_utils.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_show.dart';
import '../models/trakt_movie.dart';
import 'trakt_api_base.dart';

/// Access to calendar endpoints for all shows/movies.
class CalendarsApi extends TraktApiBase {
  /// Creates a new [CalendarsApi] instance.
  CalendarsApi(super.client);

  // === ALL SHOWS ===

  /// All Shows: Get shows airing during the time period.
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getAllShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/shows', startDate, days, extended, filters);
  }

  /// All New Shows: Get all new show premieres (series_premiere).
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getAllNewShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/shows/new', startDate, days, extended, filters);
  }

  /// All Season Premieres: Get all show premieres.
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getAllSeasonPremieres({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/shows/premieres', startDate, days, extended, filters);
  }

  /// All Finales: Get all show finales.
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getAllFinales({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/shows/finales', startDate, days, extended, filters);
  }

  // === MY SHOWS ===

  /// My Shows: Get shows airing during the time period on user's calendar.
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getMyShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/my/shows', startDate, days, extended, filters, authenticated: true);
  }

  /// My New Shows: Get all new show premieres (series_premiere).
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getMyNewShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/my/shows/new', startDate, days, extended, filters, authenticated: true);
  }

  /// My Season Premieres: Get all show premieres.
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getMySeasonPremieres({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/my/shows/premieres', startDate, days, extended, filters, authenticated: true);
  }

  /// My Finales: Get all show finales.
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarShow>> getMyFinales({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarShows('/calendars/my/shows/finales', startDate, days, extended, filters, authenticated: true);
  }

  // === ALL MOVIES ===

  /// All Movies: Get all movies with a release date during the period.
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarMovie>> getAllMovies({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarMovies('/calendars/movies', startDate, days, extended, filters);
  }

  /// All Streaming: Get all movies with a US streaming release date.
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarMovie>> getAllStreaming({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarMovies('/calendars/movies/streaming', startDate, days, extended, filters);
  }

  /// All DVD: Get all movies with a US DVD release date.
  ///
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarMovie>> getAllDvd({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarMovies('/calendars/movies/dvd', startDate, days, extended, filters);
  }

  // === MY MOVIES ===

  /// My Movies: Get all movies on user's calendar.
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarMovie>> getMyMovies({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarMovies('/calendars/my/movies', startDate, days, extended, filters, authenticated: true);
  }

  /// My Streaming: Get all movies with a US streaming release on user's calendar.
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarMovie>> getMyStreaming({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarMovies('/calendars/my/movies/streaming', startDate, days, extended, filters, authenticated: true);
  }

  /// My DVD: Get all movies with a US DVD release on user's calendar.
  ///
  /// [🔒 OAuth Required]
  /// ✨ [Extended Info] 🎚 [Filters] supported.
  Future<List<TraktCalendarMovie>> getMyDvd({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarMovies('/calendars/my/movies/dvd', startDate, days, extended, filters, authenticated: true);
  }

  // === HELPERS ===

  Future<List<TraktCalendarShow>> _getCalendarShows(
    String path,
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended,
    TraktFilters? filters, {
    bool authenticated = false,
  }) async {
    var fullPath = path;
    if (startDate != null) {
      fullPath += '/${TraktDateUtils.formatPathDate(startDate)}';
      if (days != null) fullPath += '/$days';
    }
    final queryParams = <String, String>{};
    if (extended != TraktExtendedInfo.min) queryParams['extended'] = extended.value;
    if (filters != null) queryParams.addAll(filters.toQueryParams());
    return client.get(
      fullPath,
      queryParams: queryParams.isEmpty ? null : queryParams,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktCalendarShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<List<TraktCalendarMovie>> _getCalendarMovies(
    String path,
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended,
    TraktFilters? filters, {
    bool authenticated = false,
  }) async {
    var fullPath = path;
    if (startDate != null) {
      fullPath += '/${TraktDateUtils.formatPathDate(startDate)}';
      if (days != null) fullPath += '/$days';
    }
    final queryParams = <String, String>{};
    if (extended != TraktExtendedInfo.min) queryParams['extended'] = extended.value;
    if (filters != null) queryParams.addAll(filters.toQueryParams());
    return client.get(
      fullPath,
      queryParams: queryParams.isEmpty ? null : queryParams,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktCalendarMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Represents a movie entry in a calendar.
class TraktCalendarMovie {
  /// Creates a new [TraktCalendarMovie] instance.
  TraktCalendarMovie({
    required this.released,
    required this.movie,
  });

  /// Creates a [TraktCalendarMovie] from a JSON map.
  factory TraktCalendarMovie.fromJson(Map<String, dynamic> json) {
    return TraktCalendarMovie(
      released: TraktDateUtils.parse(json['released']) ?? DateTime.now(),
      movie: TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }

  /// Date when the movie is released.
  final DateTime released;

  /// The movie object.
  final TraktMovie movie;
}

/// Represents a show entry in a calendar.
class TraktCalendarShow {
  /// Creates a new [TraktCalendarShow] instance.
  TraktCalendarShow({
    required this.firstAired,
    required this.episode,
    required this.show,
  });

  /// Creates a [TraktCalendarShow] from a JSON map.
  factory TraktCalendarShow.fromJson(Map<String, dynamic> json) {
    return TraktCalendarShow(
      firstAired: TraktDateUtils.parse(json['first_aired']) ?? DateTime.now(),
      episode: TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }

  /// Date when the episode airs.
  final DateTime firstAired;

  /// The episode object.
  final TraktEpisode episode;

  /// The show object.
  final TraktShow show;
}