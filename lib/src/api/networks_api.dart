import '../core/trakt_api_client.dart';
import '../models/trakt_media_models.dart';

class NetworksApi {
  NetworksApi(this._client);
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
