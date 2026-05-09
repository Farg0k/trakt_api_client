import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../models/trakt_calendar_movie.dart';
import '../models/trakt_calendar_show.dart';

class CalendarsApi {
  CalendarsApi(this._client);
  final TraktApiClient _client;

  // --- MY CALENDARS (Authenticated) ---

  /// [🔒 OAuth Required] Get my shows calendar.
  Future<List<TraktCalendarShow>> getMyShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/my/shows',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarShow.fromJson(json),
      authenticated: true,
    );
  }

  /// [🔒 OAuth Required] Get my new shows calendar.
  Future<List<TraktCalendarShow>> getMyNewShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/my/shows/new',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarShow.fromJson(json),
      authenticated: true,
    );
  }

  /// [🔒 OAuth Required] Get my premieres calendar.
  Future<List<TraktCalendarShow>> getMyPremieres({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/my/shows/premieres',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarShow.fromJson(json),
      authenticated: true,
    );
  }

  /// [🔒 OAuth Required] Get my movies calendar.
  Future<List<TraktCalendarMovie>> getMyMovies({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/my/movies',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarMovie.fromJson(json),
      authenticated: true,
    );
  }

  /// [🔒 OAuth Required] Get my DVD movies calendar.
  Future<List<TraktCalendarMovie>> getMyDvdMovies({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/my/dvd',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarMovie.fromJson(json),
      authenticated: true,
    );
  }

  // --- ALL CALENDARS (Public) ---

  /// Get all shows calendar.
  Future<List<TraktCalendarShow>> getAllShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/all/shows',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarShow.fromJson(json),
    );
  }

  /// Get all new shows calendar.
  Future<List<TraktCalendarShow>> getAllNewShows({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/all/shows/new',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarShow.fromJson(json),
    );
  }

  /// Get all premieres calendar.
  Future<List<TraktCalendarShow>> getAllPremieres({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/all/shows/premieres',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarShow.fromJson(json),
    );
  }

  /// Get all movies calendar.
  Future<List<TraktCalendarMovie>> getAllMovies({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/all/movies',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarMovie.fromJson(json),
    );
  }

  /// Get all DVD movies calendar.
  Future<List<TraktCalendarMovie>> getAllDvdMovies({
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
      '/calendars/all/dvd',
      startDate,
      days,
      extended,
      filters,
      (json) => TraktCalendarMovie.fromJson(json),
    );
  }

  // --- HELPERS ---

  Future<List<T>> _getCalendarList<T>(
    String basePath,
    DateTime? startDate,
    int? days,
    TraktExtendedInfo extended,
    TraktFilters? filters,
    T Function(Map<String, dynamic> json) itemMapper, {
    bool authenticated = false,
  }) async {
    var path = basePath;
    if (startDate != null) {
      path += '/${startDate.toUtc().toIso8601String().split('T')[0]}';
      if (days != null) {
        path += '/$days';
      }
    }

    final queryParams = <String, String>{'extended': extended.value};
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      path,
      queryParams: queryParams,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((item) => itemMapper(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
