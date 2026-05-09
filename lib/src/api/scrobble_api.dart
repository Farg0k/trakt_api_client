import '../core/trakt_api_client.dart';
import '../models/trakt_scrobble_models.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_episode.dart';

/// Access to scrobble endpoints.
class ScrobbleApi {

  /// Creates a new [ScrobbleApi] instance.
  ScrobbleApi(this._client);
  /// Internal client reference.
  final TraktApiClient _client;

  /// [🔒 OAuth Required] Start scrobbling a movie.
  Future<TraktScrobbleResponse> startMovie(TraktMovie movie,
      {double progress = 0, String? appVersion, String? appDate}) async {
    return _scrobble('/scrobble/start',
        {'movie': {'ids': movie.ids?.toJson()}, 'progress': progress},
        appVersion: appVersion,
        appDate: appDate);
  }

  /// [🔒 OAuth Required] Pause scrobbling a movie.
  Future<TraktScrobbleResponse> pauseMovie(TraktMovie movie,
      {double progress = 0, String? appVersion, String? appDate}) async {
    return _scrobble('/scrobble/pause',
        {'movie': {'ids': movie.ids?.toJson()}, 'progress': progress},
        appVersion: appVersion,
        appDate: appDate);
  }

  /// [🔒 OAuth Required] Stop scrobbling a movie.
  Future<TraktScrobbleResponse> stopMovie(TraktMovie movie,
      {double progress = 100, String? appVersion, String? appDate}) async {
    return _scrobble('/scrobble/stop',
        {'movie': {'ids': movie.ids?.toJson()}, 'progress': progress},
        appVersion: appVersion,
        appDate: appDate);
  }

  /// [🔒 OAuth Required] Start scrobbling an episode.
  Future<TraktScrobbleResponse> startEpisode(TraktEpisode episode,
      {double progress = 0, String? appVersion, String? appDate}) async {
    return _scrobble('/scrobble/start',
        {'episode': {'ids': episode.ids?.toJson()}, 'progress': progress},
        appVersion: appVersion,
        appDate: appDate);
  }

  /// [🔒 OAuth Required] Pause scrobbling an episode.
  Future<TraktScrobbleResponse> pauseEpisode(TraktEpisode episode,
      {double progress = 0, String? appVersion, String? appDate}) async {
    return _scrobble('/scrobble/pause',
        {'episode': {'ids': episode.ids?.toJson()}, 'progress': progress},
        appVersion: appVersion,
        appDate: appDate);
  }

  /// [🔒 OAuth Required] Stop scrobbling an episode.
  Future<TraktScrobbleResponse> stopEpisode(TraktEpisode episode,
      {double progress = 100, String? appVersion, String? appDate}) async {
    return _scrobble('/scrobble/stop',
        {'episode': {'ids': episode.ids?.toJson()}, 'progress': progress},
        appVersion: appVersion,
        appDate: appDate);
  }

  Future<TraktScrobbleResponse> _scrobble(String path, Map<String, dynamic> body,
      {String? appVersion, String? appDate}) async {
    if (appVersion != null) body['app_version'] = appVersion;
    if (appDate != null) body['app_date'] = appDate;

    return _client.post(
      path,
      authenticated: true,
      body: body,
      mapper: (body, headers) =>
          TraktScrobbleResponse.fromJson(body as Map<String, dynamic>),
    );
  }
}
