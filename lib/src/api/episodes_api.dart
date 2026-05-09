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
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';

class EpisodesApi {
  final TraktApiClient _client;

  EpisodesApi(this._client);

  /// Get detailed episode information.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktEpisode> getSummary(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktEpisode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all translations for an episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktTranslation>> getTranslations(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    String? language,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktTranslation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all comments for an episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktComment>> getComments(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktCommentSort sort = TraktCommentSort.newest,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/comments/${sort.value}',
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

  /// Get all lists that contain this episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/lists/${type.value}/${sort.value}',
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

  /// Get cast and crew for an episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktCredits> getPeople(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/people',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get rating distribution for an episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktRating> getRatings(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get episode stats.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktStats> getStats(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/stats',
      mapper: (body, headers) =>
          TraktStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users currently watching an episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktUser>> getWatching(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all videos for an episode.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktVideo>> getVideos(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get recently updated episodes.
  Future<TraktListResponse<TraktUpdate<TraktEpisode>>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/episodes/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktUpdate<TraktEpisode>.fromJson(item as Map<String, dynamic>, TraktEpisode.fromJson, 'episode'))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently updated episode IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/episodes/updates/id/$dateStr',
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

  /// Get recently deleted episodes.
  Future<TraktListResponse<TraktDeleted<TraktEpisode>>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/episodes/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktDeleted<TraktEpisode>.fromJson(item as Map<String, dynamic>, TraktEpisode.fromJson, 'episode'))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Report an episode for inappropriate content.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    required TraktReportReason reason,
    String? notes,
  }) async {
    await _client.post(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Refresh an episode to get the latest metadata from TMDB.
  /// 
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> refresh(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    await _client.post(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/refresh',
      mapper: (body, headers) => null,
    );
  }
}
