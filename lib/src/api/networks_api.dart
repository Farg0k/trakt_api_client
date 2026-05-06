import '../core/trakt_api_client.dart';
import '../models/trakt_network.dart';

class NetworksApi {
  final TraktApiClient _client;

  NetworksApi(this._client);

  /// Get a list of all TV networks.
  Future<List<TraktNetwork>> get() async {
    return _client.get(
      '/networks',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktNetwork.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
