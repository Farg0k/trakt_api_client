import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_media_entity.dart';
import 'trakt_api_base.dart';

/// Access to recommendation endpoints.
class RecommendationsApi extends TraktApiBase {
  /// Creates a new [RecommendationsApi] instance.
  RecommendationsApi(super.client);

  /// [🔒 OAuth Required] Get movie recommendations.
  Future<TraktListResponse<TraktMediaEntity>> getMovies({
    TraktPaginationParams? pagination,
    bool ignoreCollected = false,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getRecommendationsList('/recommendations/movies', pagination,
        ignoreCollected, extended, filters);
  }

  /// [🔒 OAuth Required] Hide a movie from recommendations.
  Future<void> hideMovie(String id) async {
    await client.delete(
      '/recommendations/movies/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Get show recommendations.
  Future<TraktListResponse<TraktMediaEntity>> getShows({
    TraktPaginationParams? pagination,
    bool ignoreCollected = false,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getRecommendationsList('/recommendations/shows', pagination,
        ignoreCollected, extended, filters);
  }

  /// [🔒 OAuth Required] Hide a show from recommendations.
  Future<void> hideShow(String id) async {
    await client.delete(
      '/recommendations/shows/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- HELPERS ---

  Future<TraktListResponse<TraktMediaEntity>> _getRecommendationsList(
    String path,
    TraktPaginationParams? pagination,
    bool ignoreCollected,
    TraktExtendedInfo extended,
    TraktFilters? filters,
  ) async {
    return getList(
      path,
      pagination: pagination,
      extended: extended,
      filters: filters,
      queryParams: {
        'ignore_collected': ignoreCollected.toString(),
      },
      mapper: (json) => TraktMediaEntity.fromJson(json),
    );
  }
}
