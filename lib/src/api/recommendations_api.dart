import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';

class RecommendationsApi {
  final TraktApiClient _client;

  RecommendationsApi(this._client);

  /// Get personalized movie recommendations.
  Future<List<TraktMovie>> getMovies({
    int limit = 10,
    bool ignoreCollected = false,
    bool ignoreWatchlisted = false,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      'ignore_collected': ignoreCollected.toString(),
      'ignore_watchlisted': ignoreWatchlisted.toString(),
      'extended': extended,
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/recommendations/movies',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktMovie.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Hide a movie from recommendations.
  Future<void> hideMovie(String id) async {
    await _client.delete(
      '/recommendations/movies/$id',
      mapper: (body, headers) => null,
    );
  }

  /// Get personalized show recommendations.
  Future<List<TraktShow>> getShows({
    int limit = 10,
    bool ignoreCollected = false,
    bool ignoreWatchlisted = false,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    final queryParams = <String, String>{
      'limit': limit.toString(),
      'ignore_collected': ignoreCollected.toString(),
      'ignore_watchlisted': ignoreWatchlisted.toString(),
      'extended': extended,
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/recommendations/shows',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktShow.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Hide a show from recommendations.
  Future<void> hideShow(String id) async {
    await _client.delete(
      '/recommendations/shows/$id',
      mapper: (body, headers) => null,
    );
  }
}
