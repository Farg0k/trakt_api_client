import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_period.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_list.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_media_models.dart';
import '../models/trakt_generic_models.dart';
import '../models/trakt_stats.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_api_base.dart';

/// Access to movie endpoints.
class MoviesApi extends TraktApiBase {
  /// Creates a new [MoviesApi] instance.
  MoviesApi(super.client);

  /// Get trending movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getTrending({
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/trending',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get popular movies.
  Future<TraktListResponse<TraktMovie>> getPopular({
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/movies/popular',
      pagination: pagination,
      extended: extended,
      mapper: TraktMovie.fromJson,
    );
  }

  /// Get recommended movies.
  Future<TraktListResponse<TraktMovie>> getRecommended({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/recommended${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMovie.fromJson(json['movie'] as Map<String, dynamic>),
    );
  }

  /// Get most played movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getPlayed({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/played${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get most watched movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getWatched({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/watched${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get most collected movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getCollected({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/collected${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get most anticipated movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getAnticipated({
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/anticipated',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get most favorited movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getFavorited({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/movies/favorited${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get the top 10 weekend box office.
  Future<List<TraktBoxOfficeMovie>> getBoxOffice({
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/movies/boxoffice',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map(
            (item) =>
                TraktBoxOfficeMovie.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// Get recently updated movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getUpdates(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/movies/updates/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get recently updated movie IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    TraktPaginationParams? pagination,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/movies/updates/id/$dateStr',
      pagination: pagination,
      mapper: (json) => json as int,
    );
  }

  /// Get recently deleted movies.
  Future<TraktListResponse<TraktMetadata<TraktMovie>>> getDeleted(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/movies/updates/deleted/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktMovie.fromJson, 'movie'),
    );
  }

  /// Get detailed movie information.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktMovie> getSummary(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.full,
  }) async {
    return client.get(
      '/movies/$id',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktMovie.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all title aliases for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMediaAlias>> getAliases(String id) async {
    return client.get(
      '/movies/$id/aliases',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktMediaAlias.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all certifications for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMediaCertification>> getCertifications(String id) async {
    return client.get(
      '/movies/$id/certifications',
      mapper: (body, headers) => (body as List)
          .map(
            (item) =>
                TraktMediaCertification.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// Get all languages for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<String>> getLanguages(String id) async {
    return client.get(
      '/movies/$id/languages',
      mapper: (body, headers) =>
          (body as List).map((e) => e as String).toList(),
    );
  }

  /// Get all release dates and certifications for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMovieRelease>> getReleases(
    String id, {
    String? country,
  }) async {
    return client.get(
      '/movies/$id/releases${country != null ? '/$country' : ''}',
      mapper: (body, headers) => (body as List)
          .map(
            (item) => TraktMovieRelease.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// Get all translations for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktTranslation>> getTranslations(
    String id, {
    String? language,
  }) async {
    return client.get(
      '/movies/$id/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map(
            (item) => TraktTranslation.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// Get all comments for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    TraktCommentSort sort = TraktCommentSort.newest,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/movies/$id/comments/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: TraktComment.fromJson,
    );
  }

  /// Get all lists that contain this movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String id, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    TraktPaginationParams? pagination,
  }) async {
    return getList(
      '/movies/$id/lists/${type.value}/${sort.value}',
      pagination: pagination,
      mapper: TraktList.fromJson,
    );
  }

  /// Get all cast and crew for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktCredits> getPeople(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
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
    return client.get(
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
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/movies/$id/related',
      pagination: pagination,
      extended: extended,
      mapper: TraktMovie.fromJson,
    );
  }

  /// Get movie stats.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktStats> getStats(String id) async {
    return client.get(
      '/movies/$id/stats',
      mapper: (body, headers) =>
          TraktStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all studios for a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktStudio>> getStudios(String id) async {
    return client.get(
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
    return client.get(
      '/movies/$id/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get users currently watching a movie.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktUser>> getWatching(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/movies/$id/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// 🔒 OAuth Required Report a movie for inappropriate content.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(
    String id, {
    required TraktReportReason reason,
    String? notes,
  }) async {
    await client.post(
      '/movies/$id/report',
      body: {'reason': reason.value, 'notes': notes}
        ..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// 🔒 OAuth Required Refresh a movie to get the latest metadata from TMDB.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  ///
  /// Note: This is a VIP only method.
  Future<void> refresh(String id) async {
    await client.post(
      '/movies/$id/refresh',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
