import '../core/trakt_api_client.dart';
import '../models/trakt_media_models.dart';

/// Access to network endpoints.
class NetworksApi {
  /// Creates a new [NetworksApi] instance.
  NetworksApi(this._client);

  /// Internal client reference.
  final TraktApiClient _client;

  /// Get all networks for movies or shows.
  Future<List<TraktNetwork>> getNetworks() async {
    return _client.get(
      '/networks',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktNetwork.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
