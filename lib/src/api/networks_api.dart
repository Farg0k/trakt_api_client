import '../core/trakt_api_client.dart';
import '../core/trakt_media_class.dart';
import '../models/trakt_network.dart';

class NetworksApi {
  final TraktApiClient _client;

  NetworksApi(this._client);

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
