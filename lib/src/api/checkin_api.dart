import '../core/trakt_api_client.dart';
import '../models/trakt_checkin_models.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_sharing.dart';

/// Access to checkin endpoints.
class CheckinApi {
  /// Creates a new [CheckinApi] instance.
  CheckinApi(this._client);
  /// Internal client reference.
  final TraktApiClient _client;



  /// [🔒 OAuth Required] Check into a movie.
  Future<TraktCheckinResponse> movie(
    TraktMovie movie, {
    String? message,
    TraktSharing? sharing,
    String? appVersion,
    String? appDate,
  }) async {
    return _client.post(
      '/checkin',
      authenticated: true,
      body: {
        'movie': {'ids': movie.ids?.toJson()},
        'message': ?message,
        if (sharing != null) 'sharing': sharing.toJson(),
        'app_version': ?appVersion,
        'app_date': ?appDate,
      },
      mapper: (body, headers) =>
          TraktCheckinResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Check into an episode.
  Future<TraktCheckinResponse> episode(
    TraktEpisode episode, {
    String? message,
    TraktSharing? sharing,
    String? appVersion,
    String? appDate,
  }) async {
    return _client.post(
      '/checkin',
      authenticated: true,
      body: {
        'episode': {'ids': episode.ids?.toJson()},
        'message': ?message,
        if (sharing != null) 'sharing': sharing.toJson(),
        'app_version': ?appVersion,
        'app_date': ?appDate,
      },
      mapper: (body, headers) =>
          TraktCheckinResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Delete any active checkins.
  Future<void> delete() async {
    await _client.delete(
      '/checkin',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
