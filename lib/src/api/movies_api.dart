import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_movie.dart';

class MoviesApi {
  final TraktApiClient _client;

  MoviesApi(this._client);

  Future<TraktListResponse<TraktMovie>> getTrending({
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/movies/trending',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktMovie.fromJson(item['movie'] as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  Future<TraktMovie> getDetails(
    String id, {
    String extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/movies/$id',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktMovie.fromJson(body as Map<String, dynamic>),
    );
  }
}
