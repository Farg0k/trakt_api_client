import '../core/trakt_api_client.dart';
import '../models/trakt_show.dart';

class ShowsApi {
  final TraktApiClient _client;

  ShowsApi(this._client);

  Future<List<TraktShow>> getTrending({
    int page = 1,
    int limit = 10,
    String extended = 'metadata',
  }) async {
    final response = await _client.get(
      '/shows/trending',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
    );

    return (response as List)
        .map((item) => TraktShow.fromJson(item['show'] as Map<String, dynamic>))
        .toList();
  }

  Future<TraktShow> getDetails(
    String id, {
    String extended = 'full',
  }) async {
    final response = await _client.get(
      '/shows/$id',
      queryParams: {'extended': extended},
    );

    return TraktShow.fromJson(response as Map<String, dynamic>);
  }
}
