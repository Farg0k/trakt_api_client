import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_period.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_media_certification.dart';
import '../models/trakt_movie_models.dart';
import '../models/trakt_show.dart';
import '../models/trakt_show_models.dart';
import '../models/trakt_studio.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';

class ShowsApi {
  final TraktApiClient _client;

  ShowsApi(this._client);

  /// Get trending shows.
  Future<TraktListResponse<TraktTrendingShow>> getTrending({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList('/shows/trending', page, limit, extended,
        filters, (json) => TraktTrendingShow.fromJson(json));
  }

  /// Get popular shows.
  Future<TraktListResponse<TraktShow>> getPopular({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _getShowResponseList('/shows/popular', page, limit, extended, null,
        (json) => TraktShow.fromJson(json));
  }

  /// Get recommended shows.
  Future<TraktListResponse<TraktShow>> getRecommended({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList(
        '/shows/recommended${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktShow.fromJson(json['show'] as Map<String, dynamic>));
  }

  /// Get most played shows.
  Future<TraktListResponse<TraktMostShow>> getPlayed({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList(
        '/shows/played${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostShow.fromJson(json));
  }

  /// Get most watched shows.
  Future<TraktListResponse<TraktMostShow>> getWatched({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList(
        '/shows/watched${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostShow.fromJson(json));
  }

  /// Get most collected shows.
  Future<TraktListResponse<TraktMostShow>> getCollected({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList(
        '/shows/collected${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktMostShow.fromJson(json));
  }

  /// Get most anticipated shows.
  Future<TraktListResponse<TraktAnticipatedShow>> getAnticipated({
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList('/shows/anticipated', page, limit, extended,
        filters, (json) => TraktAnticipatedShow.fromJson(json));
  }

  /// Get most favorited shows.
  Future<TraktListResponse<TraktFavoritedShow>> getFavorited({
    TraktPeriod? period,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return _getShowResponseList(
        '/shows/favorited${period != null ? '/${period.value}' : ''}',
        page,
        limit,
        extended,
        filters,
        (json) => TraktFavoritedShow.fromJson(json));
  }

  /// Get recently updated shows.
  Future<TraktListResponse<TraktShowUpdate>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/shows/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktShowUpdate.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently updated show IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/shows/updates/id/$dateStr',
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

  /// Get recently deleted shows.
  Future<TraktListResponse<TraktDeletedShow>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/shows/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktDeletedShow.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get detailed show information.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktShow> getSummary(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/shows/$id',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktShow.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all title aliases for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktShowAlias>> getAliases(String id) async {
    return _client.get(
      '/shows/$id/aliases',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktShowAlias.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all certifications for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMediaCertification>> getCertifications(String id) async {
    return _client.get(
      '/shows/$id/certifications',
      mapper: (body, headers) => (body as List)
          .map((item) =>
              TraktMediaCertification.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all languages for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<String>> getLanguages(String id) async {
    return _client.get(
      '/shows/$id/languages',
      mapper: (body, headers) => (body as List).map((e) => e as String).toList(),
    );
  }

  /// Get all translations for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktTranslation>> getTranslations(String id,
      {String? language}) async {
    return _client.get(
      '/shows/$id/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktTranslation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all comments for a show.
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
      '/shows/$id/comments/${sort.value}',
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

  /// Get all lists that contain this show.
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
      '/shows/$id/lists/${type.value}/${sort.value}',
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

  /// Get all cast and crew for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktCredits> getPeople(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/shows/$id/people',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get rating distribution for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktRating> getRatings(String id) async {
    return _client.get(
      '/shows/$id/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get related shows.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktShow>> getRelated(
    String id, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$id/related',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
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

  /// Get show stats.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktShowStats> getStats(String id) async {
    return _client.get(
      '/shows/$id/stats',
      mapper: (body, headers) =>
          TraktShowStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all studios for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktStudio>> getStudios(String id) async {
    return _client.get(
      '/shows/$id/studios',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktStudio.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all videos for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktVideo>> getVideos(String id) async {
    return _client.get(
      '/shows/$id/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get users currently watching a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktUser>> getWatching(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/shows/$id/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get collection progress for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktShowProgress> getCollectionProgress(
    String id, {
    bool hidden = false,
    bool specials = false,
    bool countSpecials = false,
  }) async {
    return _client.get(
      '/shows/$id/progress/collection',
      queryParams: {
        'hidden': hidden.toString(),
        'specials': specials.toString(),
        'count_specials': countSpecials.toString(),
      },
      mapper: (body, headers) =>
          TraktShowProgress.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get watched progress for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktShowProgress> getWatchedProgress(
    String id, {
    bool hidden = false,
    bool specials = false,
    bool countSpecials = false,
  }) async {
    return _client.get(
      '/shows/$id/progress/watched',
      queryParams: {
        'hidden': hidden.toString(),
        'specials': specials.toString(),
        'count_specials': countSpecials.toString(),
      },
      mapper: (body, headers) =>
          TraktShowProgress.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Reset watched progress for a show.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> resetWatchedProgress(String id) async {
    await _client.delete(
      '/shows/$id/progress/watched',
      mapper: (body, headers) => null,
    );
  }

  /// Get the next episode to air.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktEpisode?> getNextEpisode(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/shows/$id/next_episode',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          body == null ? null : TraktEpisode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get the last episode to air.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktEpisode?> getLastEpisode(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/shows/$id/last_episode',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          body == null ? null : TraktEpisode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Report a show for inappropriate content.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(String id,
      {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/shows/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Refresh a show to get the latest metadata from TMDB.
  /// 
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> refresh(String id) async {
    await _client.post(
      '/shows/$id/refresh',
      mapper: (body, headers) => null,
    );
  }

  // --- HELPERS ---

  Future<TraktListResponse<T>> _getShowResponseList<T>(
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
