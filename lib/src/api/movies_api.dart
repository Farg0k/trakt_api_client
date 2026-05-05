import '../core/trakt_api_client.dart';
import '../models/trakt_movie.dart';

class MoviesApi {
  final TraktApiClient _client;

  MoviesApi(this._client);

  Future<List<TraktMovie>> getTrending({
    int page = 1,
    int limit = 10,
    String extended = 'metadata',
  }) async {
    final response = await _client.get(
      '/movies/trending',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
    );

    return (response as List)
        .map((item) => TraktMovie.fromJson(item['movie'] as Map<String, dynamic>))
        .toList();
  }

  Future<TraktMovie> getDetails(
    String id, {
    String extended = 'full',
  }) async {
    final response = await _client.get(
      '/movies/$id',
      queryParams: {'extended': extended},
    );

    return TraktMovie.fromJson(response as Map<String, dynamic>);
  }
}
