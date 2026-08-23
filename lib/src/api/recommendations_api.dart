import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import 'trakt_api_base.dart';

/// Access to recommendation endpoints.
class RecommendationsApi extends TraktApiBase {
  /// Creates a new [RecommendationsApi] instance.
  RecommendationsApi(super.client);

  /// 🔒 OAuth Required Get movie recommendations.
  Future<TraktListResponse<TraktMovie>> getMovies({
    TraktPaginationParams? pagination,
    bool ignoreCollected = false,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getRecommendationsList<TraktMovie>(
      '/recommendations/movies',
      pagination: pagination,
      ignoreCollected: ignoreCollected,
      extended: extended,
      filters: filters,
      mapper: (json) => TraktMovie.fromJson(json),
    );
  }

  /// 🔒 OAuth Required Hide a movie from recommendations.
  Future<void> hideMovie(String id) async {
    await client.delete(
      '/recommendations/movies/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// 🔒 OAuth Required Get show recommendations.
  Future<TraktListResponse<TraktShow>> getShows({
    TraktPaginationParams? pagination,
    bool ignoreCollected = false,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getRecommendationsList<TraktShow>(
      '/recommendations/shows',
      pagination: pagination,
      ignoreCollected: ignoreCollected,
      extended: extended,
      filters: filters,
      mapper: (json) => TraktShow.fromJson(json),
    );
  }

  /// 🔒 OAuth Required Hide a show from recommendations.
  Future<void> hideShow(String id) async {
    await client.delete(
      '/recommendations/shows/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- HELPERS ---

  Future<TraktListResponse<T>> _getRecommendationsList<T>(
    String path, {
    TraktPaginationParams? pagination,
    required bool ignoreCollected,
    required TraktExtendedInfo extended,
    TraktFilters? filters,
    required T Function(Map<String, dynamic> json) mapper,
  }) async {
    return getList(
      path,
      pagination: pagination,
      extended: extended,
      filters: filters,
      authenticated: true,
      queryParams: {'ignore_collected': ignoreCollected.toString()},
      mapper: mapper,
    );
  }
}
