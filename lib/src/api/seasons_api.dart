import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_movie_models.dart';
import '../models/trakt_season.dart';
import '../models/trakt_show_models.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';

class SeasonsApi {
  final TraktApiClient _client;

  SeasonsApi(this._client);

  /// Get all seasons for a show.
  Future<List<TraktSeason>> getAll(
    String showId, {
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/shows/$showId/seasons',
      queryParams: {'extended': extended},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktSeason.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all episodes for a single season.
  Future<List<TraktEpisode>> getEpisodes(
    String showId,
    int seasonNumber, {
    String extended = TraktExtendedInfo.metadata,
    String? translations,
  }) async {
    final queryParams = <String, String>{'extended': extended};
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
  Future<List<TraktTranslation>> getTranslations(String showId, int seasonNumber,
      {String? language}) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktTranslation.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all comments for a season.
  Future<TraktListResponse<TraktComment>> getComments(
    String showId,
    int seasonNumber, {
    String sort = 'newest',
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/comments/$sort',
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

  /// Get all lists that contain this season.
  Future<TraktListResponse<TraktList>> getLists(
    String showId,
    int seasonNumber, {
    String type = 'personal',
    String sort = 'popular',
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/lists/$type/$sort',
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

  /// Get cast and crew for a season.
  Future<TraktCredits> getPeople(
    String showId,
    int seasonNumber, {
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/people',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get rating distribution for a season.
  Future<TraktRating> getRatings(String showId, int seasonNumber) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get season stats.
  Future<TraktShowStats> getStats(String showId, int seasonNumber) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/stats',
      mapper: (body, headers) =>
          TraktShowStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users currently watching a season.
  Future<List<TraktUser>> getWatching(
    String showId,
    int seasonNumber, {
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/watching',
      queryParams: {'extended': extended},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all videos for a season.
  Future<List<TraktVideo>> getVideos(String showId, int seasonNumber) async {
    return _client.get(
      '/shows/$showId/seasons/$seasonNumber/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get recently updated seasons.
  Future<TraktListResponse<TraktSeasonUpdate>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
    return _client.get(
      '/seasons/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktSeasonUpdate.fromJson(item as Map<String, dynamic>))
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
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
    return _client.get(
      '/seasons/updates/id/$dateStr',
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

  /// Get recently deleted seasons.
  Future<TraktListResponse<TraktDeletedSeason>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
    return _client.get(
      '/seasons/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktDeletedSeason.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Report a season for inappropriate content.
  Future<void> report(String showId, int seasonNumber,
      {required String reason, String? notes}) async {
    await _client.post(
      '/shows/$showId/seasons/$seasonNumber/report',
      body: {
        'reason': reason,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      mapper: (body, headers) => null,
    );
  }

  /// Refresh a season to get the latest metadata from TMDB.
  Future<void> refresh(String showId, int seasonNumber) async {
    await _client.post(
      '/shows/$showId/seasons/$seasonNumber/refresh',
      mapper: (body, headers) => null,
    );
  }
}
