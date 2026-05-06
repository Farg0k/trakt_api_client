import '../core/trakt_api_client.dart';
import '../models/trakt_scrobble_models.dart';

class ScrobbleApi {
  final TraktApiClient _client;

  ScrobbleApi(this._client);

  /// Start scrobbling a movie or episode.
  ///
  /// This should be called when the user starts watching or resumes playback.
  Future<TraktScrobbleResponse> start(TraktScrobbleRequest request) async {
    return _client.post(
      '/scrobble/start',
      body: request.toJson(),
      mapper: (body, headers) =>
          TraktScrobbleResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Pause scrobbling a movie or episode.
  ///
  /// This should be called when the user pauses playback.
  Future<TraktScrobbleResponse> pause(TraktScrobbleRequest request) async {
    return _client.post(
      '/scrobble/pause',
      body: request.toJson(),
      mapper: (body, headers) =>
          TraktScrobbleResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Stop scrobbling a movie or episode.
  ///
  /// This should be called when the user stops watching or the media finishes.
  Future<TraktScrobbleResponse> stop(TraktScrobbleRequest request) async {
    return _client.post(
      '/scrobble/stop',
      body: request.toJson(),
      mapper: (body, headers) =>
          TraktScrobbleResponse.fromJson(body as Map<String, dynamic>),
    );
  }
}
