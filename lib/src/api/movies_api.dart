import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_list.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_movie_models.dart';
import '../models/trakt_user.dart';

class MoviesApi {
  final TraktApiClient _client;

  MoviesApi(this._client);

  /// Get trending movies.
  Future<TraktListResponse<TraktTrendingMovie>> getTrending({
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList('/movies/trending', page, limit, extended,
        filters, (json) => TraktTrendingMovie.fromJson(json));
  }

  /// Get popular movies.
  Future<TraktListResponse<TraktMovie>> getPopular({
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _getMovieResponseList('/movies/popular', page, limit, extended, null,
        (json) => TraktMovie.fromJson(json));
  }

  /// Get recommended movies.
  Future<TraktListResponse<TraktMovie>> getRecommended({
    String? period,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/recommended${period != null ? '/$period' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMovie.fromJson(json['movie'] as Map<String, dynamic>));
  }

  /// Get most played movies.
  Future<TraktListResponse<TraktMostMovie>> getPlayed({
    String? period,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/played${period != null ? '/$period' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostMovie.fromJson(json));
  }

  /// Get most watched movies.
  Future<TraktListResponse<TraktMostMovie>> getWatched({
    String? period,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/watched${period != null ? '/$period' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostMovie.fromJson(json));
  }

  /// Get most collected movies.
  Future<TraktListResponse<TraktMostMovie>> getCollected({
    String? period,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/collected${period != null ? '/$period' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostMovie.fromJson(json));
  }

  /// Get most anticipated movies.
  Future<TraktListResponse<TraktAnticipatedMovie>> getAnticipated({
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList('/movies/anticipated', page, limit, extended,
        filters, (json) => TraktAnticipatedMovie.fromJson(json));
  }

  /// Get most favorited movies.
  Future<TraktListResponse<TraktFavoritedMovie>> getFavorited({
    String? period,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/favorited${period != null ? '/$period' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktFavoritedMovie.fromJson(json));
  }

  /// Get the top 10 weekend box office.
  Future<List<TraktBoxOfficeMovie>> getBoxOffice({
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/movies/boxoffice',
      queryParams: {'extended': extended},
      mapper: (body, headers) => (body as List)
          .map((item) =>
              TraktBoxOfficeMovie.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get recently updated movies.
  Future<TraktListResponse<TraktMovieUpdate>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final dateStr = startDate.toIso8601String().split('T')[0];
    return _client.get(
      '/movies/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktMovieUpdate.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently updated movie IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
  }) async {
    final dateStr = startDate.toIso8601String().split('T')[0];
    return _client.get(
      '/movies/updates/id/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List).map((item) => item as int).toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently deleted movies.
  Future<TraktListResponse<TraktDeletedMovie>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final dateStr = startDate.toIso8601String().split('T')[0];
    return _client.get(
      '/movies/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktDeletedMovie.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get detailed movie information.
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

  /// Get all title aliases for a movie.
  Future<List<TraktMovieAlias>> getAliases(String id) async {
    return _client.get(
      '/movies/$id/aliases',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktMovieAlias.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all release dates and certifications for a movie.
  Future<List<TraktMovieRelease>> getReleases(String id,
      {String? country}) async {
    return _client.get(
      '/movies/$id/releases${country != null ? '/$country' : ''}',
      mapper: (body, headers) => (body as List)
          .map((item) =>
              TraktMovieRelease.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all translations for a movie.
  Future<List<TraktTranslation>> getTranslations(String id,
      {String? language}) async {
    return _client.get(
      '/movies/$id/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktTranslation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all comments for a movie.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    String sort = 'newest',
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/movies/$id/comments/$sort',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktComment.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get all lists that contain this movie.
  Future<TraktListResponse<TraktList>> getLists(
    String id, {
    String type = 'personal',
    String sort = 'popular',
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/movies/$id/lists/$type/$sort',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktList.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get all cast and crew for a movie.
  Future<TraktCredits> getPeople(String id,
      {String extended = TraktExtendedInfo.metadata}) async {
    return _client.get(
      '/movies/$id/people',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get rating distribution for a movie.
  Future<TraktRating> getRatings(String id) async {
    return _client.get(
      '/movies/$id/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get related movies.
  Future<TraktListResponse<TraktMovie>> getRelated(
    String id, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/movies/$id/related',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
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

  /// Get movie stats.
  Future<TraktMovieStats> getStats(String id) async {
    return _client.get(
      '/movies/$id/stats',
      mapper: (body, headers) =>
          TraktMovieStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users currently watching a movie.
  Future<List<TraktUser>> getWatching(String id,
      {String extended = TraktExtendedInfo.metadata}) async {
    return _client.get(
      '/movies/$id/watching',
      queryParams: {'extended': extended},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Report a movie for inappropriate content.
  ///
  /// [reason] must be one of: off-topic, offensive, spam, other.
  Future<void> report(String id, {required String reason, String? notes}) async {
    await _client.post(
      '/movies/$id/report',
      body: {
        'reason': reason,
        if (notes != null) 'notes': notes,
      },
      mapper: (body, headers) => null,
    );
  }

  /// Refresh a movie to get the latest metadata from TMDB.
  ///
  /// Note: This is a VIP only method.
  Future<void> refresh(String id) async {
    await _client.post(
      '/movies/$id/refresh',
      mapper: (body, headers) => null,
    );
  }

  // --- HELPERS ---

  Future<TraktListResponse<T>> _getMovieResponseList<T>(
    String path,
    int page,
    int limit,
    String extended,
    TraktFilters? filters,
    T Function(Map<String, dynamic> json) itemMapper,
  ) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended,
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      path,
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => itemMapper(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }
}
