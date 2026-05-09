import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_media_entity.dart';

/// Access to recommendation endpoints.
class RecommendationsApi {

  /// Creates a new [RecommendationsApi] instance.
  RecommendationsApi(this._client);
  /// Internal client reference.
  final TraktApiClient _client;

  /// [🔒 OAuth Required] Get movie recommendations.
  Future<TraktListResponse<TraktMediaEntity>> getMovies({
    int page = 1,
    int limit = 10,
    bool ignoreCollected = false,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getRecommendationsList('/recommendations/movies', page, limit,
        ignoreCollected, extended, filters);
  }

  /// [🔒 OAuth Required] Hide a movie from recommendations.
  Future<void> hideMovie(String id) async {
    await _client.delete(
      '/recommendations/movies/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Get show recommendations.
  Future<TraktListResponse<TraktMediaEntity>> getShows({
    int page = 1,
    int limit = 10,
    bool ignoreCollected = false,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getRecommendationsList('/recommendations/shows', page, limit,
        ignoreCollected, extended, filters);
  }

  /// [🔒 OAuth Required] Hide a show from recommendations.
  Future<void> hideShow(String id) async {
    await _client.delete(
      '/recommendations/shows/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- HELPERS ---

  Future<TraktListResponse<TraktMediaEntity>> _getRecommendationsList(
    String path,
    int page,
    int limit,
    bool ignoreCollected,
    TraktExtendedInfo extended,
    TraktFilters? filters,
  ) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'ignore_collected': ignoreCollected.toString(),
      'extended': extended.value,
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      path,
      authenticated: true,
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktMediaEntity.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }
}
