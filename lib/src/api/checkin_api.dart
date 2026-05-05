import '../core/trakt_api_client.dart';
import '../models/trakt_checkin_models.dart';

class CheckinApi {
  final TraktApiClient _client;

  CheckinApi(this._client);

  /// Check into a movie or episode.
  ///
  /// This should be called when the user starts watching something.
  /// Only one check-in can be active at a time.
  ///
  /// If a check-in is already in progress, this will throw a [TraktApiException]
  /// with status 409 (Conflict).
  Future<TraktCheckinResponse> checkin(TraktCheckinRequest request) async {
    return _client.post(
      '/checkin',
      body: request.toJson(),
      mapper: (body, headers) =>
          TraktCheckinResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Removes any active check-ins.
  ///
  /// This should be called if the user stops watching or if you want to
  /// clear an existing check-in before starting a new one.
  Future<void> deleteActiveCheckins() async {
    await _client.delete(
      '/checkin',
      mapper: (body, headers) => null,
    );
  }
}
