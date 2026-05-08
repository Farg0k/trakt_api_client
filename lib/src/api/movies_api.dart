import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_period.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_list.dart';
import '../models/trakt_media_certification.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_movie_models.dart';
import '../models/trakt_studio.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';

class MoviesApi {
  final TraktApiClient _client;

  MoviesApi(this._client);

  /// Get trending movies.
  Future<TraktListResponse<TraktTrendingMovie>> getTrending({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList('/movies/trending', page, limit, extended,
        filters, (json) => TraktTrendingMovie.fromJson(json));
  }

  /// Get popular movies.
  Future<TraktListResponse<TraktMovie>> getPopular({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _getMovieResponseList('/movies/popular', page, limit, extended, null,
        (json) => TraktMovie.fromJson(json));
  }

  /// Get recommended movies.
  Future<TraktListResponse<TraktMovie>> getRecommended({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/recommended${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMovie.fromJson(json['movie'] as Map<String, dynamic>));
  }

  /// Get most played movies.
  Future<TraktListResponse<TraktMostMovie>> getPlayed({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/played${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostMovie.fromJson(json));
  }

  /// Get most watched movies.
  Future<TraktListResponse<TraktMostMovie>> getWatched({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/watched${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostMovie.fromJson(json));
  }

  /// Get most collected movies.
  Future<TraktListResponse<TraktMostMovie>> getCollected({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/collected${period != null ? '/${period.value}' : ''}',
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
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList('/movies/anticipated', page, limit, extended,
        filters, (json) => TraktAnticipatedMovie.fromJson(json));
  }

  /// Get most favorited movies.
  Future<TraktListResponse<TraktFavoritedMovie>> getFavorited({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getMovieResponseList(
        '/movies/favorited${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktFavoritedMovie.fromJson(json));
  }

  /// Get the top 10 weekend box office.
  Future<List<TraktBoxOfficeMovie>> getBoxOffice({
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/movies/boxoffice',
      queryParams: {'extended': extended.value},
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
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/movies/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
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
    final dateStr = TraktDateUtils.formatPathDate(startDate);
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
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/movies/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
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
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktMovie> getSummary(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/movies/$id',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktMovie.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all title aliases for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMovieAlias>> getAliases(String id) async {
    return _client.get(
      '/movies/$id/aliases',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktMovieAlias.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all certifications for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMediaCertification>> getCertifications(String id) async {
    return _client.get(
      '/movies/$id/certifications',
      mapper: (body, headers) => (body as List)
          .map((item) =>
              TraktMediaCertification.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all languages for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<String>> getLanguages(String id) async {
    return _client.get(
      '/movies/$id/languages',
      mapper: (body, headers) => (body as List).map((e) => e as String).toList(),
    );
  }

  /// Get all release dates and certifications for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
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
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
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
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    TraktCommentSort sort = TraktCommentSort.newest,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/movies/$id/comments/${sort.value}',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
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
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String id, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/movies/$id/lists/${type.value}/${sort.value}',
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
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktCredits> getPeople(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/movies/$id/people',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get rating distribution for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktRating> getRatings(String id) async {
    return _client.get(
      '/movies/$id/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get related movies.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktMovie>> getRelated(
    String id, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/movies/$id/related',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
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
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktMovieStats> getStats(String id) async {
    return _client.get(
      '/movies/$id/stats',
      mapper: (body, headers) =>
          TraktMovieStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all studios for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktStudio>> getStudios(String id) async {
    return _client.get(
      '/movies/$id/studios',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktStudio.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all videos for a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktVideo>> getVideos(String id) async {
    return _client.get(
      '/movies/$id/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get users currently watching a movie.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktUser>> getWatching(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/movies/$id/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Report a movie for inappropriate content.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(String id,
      {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/movies/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Refresh a movie to get the latest metadata from TMDB.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  ///
  /// Note: This is a VIP only method.
  Future<void> refresh(String id) async {
    await _client.post(
      '/movies/$id/refresh',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- HELPERS ---

  Future<TraktListResponse<T>> _getMovieResponseList<T>(
    String path,
    int page,
    int limit,
    TraktExtendedInfo extended,
    TraktFilters? filters,
    T Function(Map<String, dynamic> json) itemMapper,
  ) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
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
