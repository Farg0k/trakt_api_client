import '../core/trakt_date_utils.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_show.dart';
import '../models/trakt_movie.dart';
import 'trakt_api_base.dart';

/// Access to calendar endpoints.
class CalendarsApi extends TraktApiBase {
  /// Creates a new [CalendarsApi] instance.
  CalendarsApi(super.client);

  /// Get movie calendar entries.
  Future<List<TraktCalendarMovie>> getMovies({
    DateTime? startDate,
    int? days,
    bool authenticated = false,
  }) async {
    final path = _buildPath('/calendars/movies', startDate, days, authenticated);
    return client.get(
      path,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktCalendarMovie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get show calendar entries.
  Future<List<TraktCalendarShow>> getShows({
    DateTime? startDate,
    int? days,
    bool authenticated = false,
  }) async {
    final path = _buildPath('/calendars/shows', startDate, days, authenticated);
    return client.get(
      path,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktCalendarShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get new show calendar entries.
  Future<List<TraktCalendarShow>> getNewShows({
    DateTime? startDate,
    int? days,
    bool authenticated = false,
  }) async {
    final path =
        _buildPath('/calendars/shows/new', startDate, days, authenticated);
    return client.get(
      path,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktCalendarShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get premiere show calendar entries.
  Future<List<TraktCalendarShow>> getPremieres({
    DateTime? startDate,
    int? days,
    bool authenticated = false,
  }) async {
    final path = _buildPath(
        '/calendars/shows/premieres', startDate, days, authenticated);
    return client.get(
      path,
      authenticated: authenticated,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktCalendarShow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // --- HELPERS ---

  String _buildPath(
      String base, DateTime? startDate, int? days, bool authenticated) {
    var path = base;
    if (authenticated) path = path.replaceFirst('/calendars', '/calendars/my');
    if (startDate != null) {
      path += '/${TraktDateUtils.formatPathDate(startDate)}';
      if (days != null) path += '/$days';
    }
    return path;
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
