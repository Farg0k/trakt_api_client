import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';

class RecommendationsApi {
  RecommendationsApi(this._client);
  final TraktApiClient _client;

  /// [🔒 OAuth Required] Get personalized movie recommendations.
  Future<TraktListResponse<TraktMovie>> getMovies({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
    bool ignoreCollected = false,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
      'ignore_collected': ignoreCollected.toString(),
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/recommendations/movies',
      queryParams: queryParams,
      authenticated: true,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktMovie.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Hide a movie from recommendations.
  Future<void> hideMovie(String id) async {
    await _client.delete(
      '/recommendations/movies/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Get personalized show recommendations.
  Future<TraktListResponse<TraktShow>> getShows({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
    bool ignoreCollected = false,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
      'ignore_collected': ignoreCollected.toString(),
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/recommendations/shows',
      queryParams: queryParams,
      authenticated: true,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktShow.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Hide a show from recommendations.
  Future<void> hideShow(String id) async {
    await _client.delete(
      '/recommendations/shows/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
