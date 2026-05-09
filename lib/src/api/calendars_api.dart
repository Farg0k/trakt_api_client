import '../core/trakt_api_client.dart';
import '../core/trakt_date_utils.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../models/trakt_calendar_movie.dart';
import '../models/trakt_calendar_show.dart';

/// Access to calendar endpoints.
class CalendarsApi {
  /// Creates a new [CalendarsApi] instance.
  CalendarsApi(this._client);
  /// Internal client reference.
  final TraktApiClient _client;

  // --- MY CALENDARS (OAuth Required) ---

  /// [🔒 OAuth Required] Get my show calendar.
  Future<List<TraktCalendarShow>> getMyShows({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/my/shows', startDate, days, extended, filters, true,
        (json) => TraktCalendarShow.fromJson(json));
  }

  /// [🔒 OAuth Required] Get my new show calendar.
  Future<List<TraktCalendarShow>> getMyNewShows({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/my/shows/new', startDate, days, extended, filters, true,
        (json) => TraktCalendarShow.fromJson(json));
  }

  /// [🔒 OAuth Required] Get my show premiere calendar.
  Future<List<TraktCalendarShow>> getMyPremieres({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList('/calendars/my/shows/premieres', startDate, days,
        extended, filters, true, (json) => TraktCalendarShow.fromJson(json));
  }

  /// [🔒 OAuth Required] Get my movie calendar.
  Future<List<TraktCalendarMovie>> getMyMovies({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/my/movies', startDate, days, extended, filters, true,
        (json) => TraktCalendarMovie.fromJson(json));
  }

  /// [🔒 OAuth Required] Get my dvd calendar.
  Future<List<TraktCalendarMovie>> getMyDvd({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/my/dvd', startDate, days, extended, filters, true,
        (json) => TraktCalendarMovie.fromJson(json));
  }

  // --- ALL CALENDARS (Public) ---

  /// Get all show calendar.
  Future<List<TraktCalendarShow>> getAllShows({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/all/shows', startDate, days, extended, filters, false,
        (json) => TraktCalendarShow.fromJson(json));
  }

  /// Get all new show calendar.
  Future<List<TraktCalendarShow>> getAllNewShows({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/all/shows/new', startDate, days, extended, filters, false,
        (json) => TraktCalendarShow.fromJson(json));
  }

  /// Get all show premiere calendar.
  Future<List<TraktCalendarShow>> getAllPremieres({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList('/calendars/all/shows/premieres', startDate, days,
        extended, filters, false, (json) => TraktCalendarShow.fromJson(json));
  }

  /// Get all movie calendar.
  Future<List<TraktCalendarMovie>> getAllMovies({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/all/movies', startDate, days, extended, filters, false,
        (json) => TraktCalendarMovie.fromJson(json));
  }

  /// Get all dvd calendar.
  Future<List<TraktCalendarMovie>> getAllDvd({
    DateTime? startDate,
    int days = 7,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getCalendarList(
        '/calendars/all/dvd', startDate, days, extended, filters, false,
        (json) => TraktCalendarMovie.fromJson(json));
  }

  // --- HELPERS ---

  Future<List<T>> _getCalendarList<T>(
    String path,
    DateTime? startDate,
    int days,
    TraktExtendedInfo extended,
    TraktFilters? filters,
    bool authenticated,
    T Function(Map<String, dynamic> json) itemMapper,
  ) async {
    final startStr = startDate != null
        ? '/${TraktDateUtils.formatPathDate(startDate)}'
        : '';
    final fullPath = '$path$startStr/$days';

    final queryParams = <String, String>{'extended': extended.value};
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      fullPath,
      queryParams: queryParams,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((item) => itemMapper(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
