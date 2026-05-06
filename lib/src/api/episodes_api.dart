import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_movie_models.dart';
import '../models/trakt_show_models.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';

class EpisodesApi {
  final TraktApiClient _client;

  EpisodesApi(this._client);

  /// Get detailed episode information.
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
  Future<TraktListResponse<TraktList>> getLists(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktListType type = TraktListType.personal,
    String sort = 'popular',
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/lists/${type.value}/$sort',
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
  Future<TraktShowStats> getStats(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/stats',
      mapper: (body, headers) =>
          TraktShowStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users currently watching an episode.
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
  Future<TraktListResponse<TraktEpisodeUpdate>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
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
                TraktEpisodeUpdate.fromJson(item as Map<String, dynamic>))
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
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
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
  Future<TraktListResponse<TraktDeletedEpisode>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
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
                TraktDeletedEpisode.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Report an episode for inappropriate content.
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
      mapper: (body, headers) => null,
    );
  }

  /// Refresh an episode to get the latest metadata from TMDB.
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
