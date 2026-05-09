import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_media_models.dart';
import '../models/trakt_generic_models.dart';
import '../models/trakt_stats.dart';
import '../models/trakt_season.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';

class SeasonsApi {
  SeasonsApi(this._client);
  final TraktApiClient _client;

  /// Get all seasons for a show.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktSeason>> getAll(
    String showId, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktSeason.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all episodes for a single season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktEpisode>> getEpisodes(
    String showId,
    int seasonNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    String? translations,
  }) async {
    final queryParams = <String, String>{'extended': extended.value};
    if (translations != null) queryParams['translations'] = translations;

    return _client.get(
      '/shows/$showId/seasons/$seasonNumber',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktEpisode.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all translations for a season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktTranslation>> getTranslations(
    String showId,
    int seasonNumber, {
    String? language,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map(
            (item) => TraktTranslation.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// Get all comments for a season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktComment>> getComments(
    String showId,
    int seasonNumber, {
    TraktCommentSort sort = TraktCommentSort.newest,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/comments/${sort.value}',
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

  /// Get all lists that contain this season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String showId,
    int seasonNumber, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/lists/${type.value}/${sort.value}',
      queryParams: {'page': page.toString(), 'limit': limit.toString()},
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

  /// Get cast and crew for a season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktCredits> getPeople(
    String showId,
    int seasonNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/people',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get rating distribution for a season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktRating> getRatings(String showId, int seasonNumber) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get season stats.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktStats> getStats(String showId, int seasonNumber) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/stats',
      mapper: (body, headers) =>
          TraktStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users currently watching a season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktUser>> getWatching(
    String showId,
    int seasonNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all videos for a season.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktVideo>> getVideos(String showId, int seasonNumber) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get recently updated seasons.
  Future<TraktListResponse<TraktUpdate<TraktSeason>>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/seasons/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map(
              (item) => TraktUpdate<TraktSeason>.fromJson(
                item as Map<String, dynamic>,
                TraktSeason.fromJson,
                'season',
              ),
            )
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently updated season IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/seasons/updates/id/$dateStr',
      queryParams: {'page': page.toString(), 'limit': limit.toString()},
      mapper: (body, headers) {
        final data = (body as List).map((item) => item as int).toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently deleted seasons.
  Future<TraktListResponse<TraktDeleted<TraktSeason>>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/seasons/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map(
              (item) => TraktDeleted<TraktSeason>.fromJson(
                item as Map<String, dynamic>,
                TraktSeason.fromJson,
                'season',
              ),
            )
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Report a season for inappropriate content.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(
    String showId,
    int seasonNumber, {
    required TraktReportReason reason,
    String? notes,
  }) async {
    await _client.post(
      '/shows/$showId/seasons/$seasonNumber/report',
      body: {'reason': reason.value, 'notes': notes}
        ..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Refresh a season to get the latest metadata from TMDB.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> refresh(String showId, int seasonNumber) async {
    await _client.post(
      '/shows/$showId/seasons/$seasonNumber/refresh',
      mapper: (body, headers) => null,
    );
  }
}
