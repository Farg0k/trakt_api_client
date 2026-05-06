import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../models/trakt_calendar_movie.dart';
import '../models/trakt_calendar_show.dart';

class CalendarsApi {
  final TraktApiClient _client;

  CalendarsApi(this._client);

  // --- ALL (Public) ---

  Future<List<TraktCalendarMovie>> getAllMovies({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getMovies('/calendars/all/movies', startDate, days, extended);

  Future<List<TraktCalendarMovie>> getAllDvd({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getMovies('/calendars/all/dvd', startDate, days, extended);

  Future<List<TraktCalendarShow>> getAllShows({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getShows('/calendars/all/shows', startDate, days, extended);

  Future<List<TraktCalendarShow>> getAllNewShows({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getShows('/calendars/all/shows/new', startDate, days, extended);

  Future<List<TraktCalendarShow>> getAllPremieres({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getShows('/calendars/all/shows/premieres', startDate, days, extended);

  // --- MY (Authenticated) ---

  Future<List<TraktCalendarMovie>> getMyMovies({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getMovies('/calendars/my/movies', startDate, days, extended);

  Future<List<TraktCalendarMovie>> getMyDvd({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getMovies('/calendars/my/dvd', startDate, days, extended);

  Future<List<TraktCalendarShow>> getMyShows({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getShows('/calendars/my/shows', startDate, days, extended);

  Future<List<TraktCalendarShow>> getMyNewShows({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getShows('/calendars/my/shows/new', startDate, days, extended);

  Future<List<TraktCalendarShow>> getMyPremieres({
    DateTime? startDate,
    int days = 7,
    String extended = TraktExtendedInfo.metadata,
  }) =>
      _getShows('/calendars/my/shows/premieres', startDate, days, extended);

  // --- HELPERS ---

  Future<List<TraktCalendarMovie>> _getMovies(
    String basePath,
    DateTime? startDate,
    int days,
    String extended,
  ) async {
    final path = _buildPath(basePath, startDate, days);
    return _client.get(
      path,
      queryParams: {'extended': extended},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktCalendarMovie.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Future<List<TraktCalendarShow>> _getShows(
    String basePath,
    DateTime? startDate,
    int days,
    String extended,
  ) async {
    final path = _buildPath(basePath, startDate, days);
    return _client.get(
      path,
      queryParams: {'extended': extended},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktCalendarShow.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  String _buildPath(String basePath, DateTime? startDate, int days) {
    var path = basePath;
    if (startDate != null) {
      final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
      path += '/$dateStr';
      path += '/$days';
    } else if (days != 7) {
      final today = DateTime.now().toUtc().toIso8601String().split('T')[0];
      path += '/$today/$days';
    }
    return path;
  }
}
