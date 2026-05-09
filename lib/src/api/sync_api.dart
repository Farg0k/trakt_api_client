import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_media_entity.dart';
import '../models/trakt_media_state.dart';
import '../models/trakt_sync_models.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import '../core/trakt_date_utils.dart';

class SyncApi {
  SyncApi(this._client);
  final TraktApiClient _client;

  /// [🔒 OAuth Required] Get the last activities for the authenticated user.
  Future<TraktLastActivities> getLastActivities() async {
    return _client.get(
      '/sync/last_activities',
      authenticated: true,
      mapper: (body, headers) =>
          TraktLastActivities.fromJson(body as Map<String, dynamic>),
    );
  }

  // --- PLAYBACK ---

  /// [🔒 OAuth Required] Get playback progress for movies and episodes.
  Future<List<TraktSyncPlayback>> getPlaybackProgress({
    TraktMediaType? type,
    int? limit,
  }) async {
    final queryParams = <String, String>{};
    if (type != null) queryParams['type'] = type.singularValue;
    if (limit != null) queryParams['limit'] = limit.toString();

    return _client.get(
      '/sync/playback',
      queryParams: queryParams,
      authenticated: true,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktSyncPlayback.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Get a specific playback progress item.
  Future<TraktSyncPlayback?> getPlaybackItem(int id) async {
    return _client.get(
      '/sync/playback/$id',
      authenticated: true,
      mapper: (body, headers) => body == null
          ? null
          : TraktSyncPlayback.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove a playback progress item.
  Future<void> removePlaybackProgress(int id) async {
    await _client.delete(
      '/sync/playback/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- COLLECTION ---

  /// [🔒 OAuth Required] Get the user's collection.
  Future<List<TraktMediaState<T>>> getCollection<T>({
    required TraktMediaType type,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/sync/collection/${type.value}',
      queryParams: {'extended': extended.value},
      authenticated: true,
      mapper: (body, headers) {
        final list = body as List;
        return list.map((e) {
          final json = e as Map<String, dynamic>;
          if (type == TraktMediaType.movies) {
            return TraktMediaState<TraktMovie>.fromJson(
                  json,
                  TraktMovie.fromJson,
                  'movie',
                )
                as TraktMediaState<T>;
          } else {
            return TraktMediaState<TraktShow>.fromJson(
                  json,
                  TraktShow.fromJson,
                  'show',
                )
                as TraktMediaState<T>;
          }
        }).toList();
      },
    );
  }

  /// [🔒 OAuth Required] Add items to the user's collection.
  Future<TraktSyncResponse> addToCollection(TraktSyncRequest request) async {
    return _client.post(
      '/sync/collection',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove items from the user's collection.
  Future<TraktSyncResponse> removeFromCollection(
    TraktSyncRequest request,
  ) async {
    return _client.post(
      '/sync/collection/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  // --- WATCHED ---

  /// [🔒 OAuth Required] Get the user's watched items.
  Future<List<TraktMediaState<T>>> getWatched<T>({
    required TraktMediaType type,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/sync/watched/${type.value}',
      queryParams: {'extended': extended.value},
      authenticated: true,
      mapper: (body, headers) {
        final list = body as List;
        return list.map((e) {
          final json = e as Map<String, dynamic>;
          if (type == TraktMediaType.movies) {
            return TraktMediaState<TraktMovie>.fromJson(
                  json,
                  TraktMovie.fromJson,
                  'movie',
                )
                as TraktMediaState<T>;
          } else {
            return TraktMediaState<TraktShow>.fromJson(
                  json,
                  TraktShow.fromJson,
                  'show',
                )
                as TraktMediaState<T>;
          }
        }).toList();
      },
    );
  }

  // --- HISTORY ---

  /// [🔒 OAuth Required] Get the user's watch history.
  Future<TraktListResponse<TraktSyncHistory>> getHistory({
    TraktMediaType? type,
    int? id,
    DateTime? startAt,
    DateTime? endAt,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    var path = '/sync/history';
    if (type != null) {
      path += '/${type.value}';
      if (id != null) path += '/$id';
    }

    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
    };
    if (startAt != null)
      queryParams['start_at'] = TraktDateUtils.formatFullDate(startAt);
    if (endAt != null)
      queryParams['end_at'] = TraktDateUtils.formatFullDate(endAt);

    return _client.get(
      path,
      queryParams: queryParams,
      authenticated: true,
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktSyncHistory.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Add items to the user's watch history.
  Future<TraktSyncResponse> addToHistory(TraktSyncRequest request) async {
    return _client.post(
      '/sync/history',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove items from the user's watch history.
  Future<TraktSyncResponse> removeFromHistory(TraktSyncRequest request) async {
    return _client.post(
      '/sync/history/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  // --- RATINGS ---

  /// [🔒 OAuth Required] Get the user's ratings.
  Future<List<TraktSyncRating>> getRatings({
    required TraktMediaType type,
    int? rating,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    var path = '/sync/ratings/${type.value}';
    if (rating != null) path += '/$rating';

    return _client.get(
      path,
      queryParams: {'extended': extended.value},
      authenticated: true,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktSyncRating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Add ratings to items.
  Future<TraktSyncResponse> addRatings(TraktSyncRequest request) async {
    return _client.post(
      '/sync/ratings',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove ratings from items.
  Future<TraktSyncResponse> removeRatings(TraktSyncRequest request) async {
    return _client.post(
      '/sync/ratings/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  // --- WATCHLIST ---

  /// [🔒 OAuth Required] Get the user's watchlist.
  Future<TraktListResponse<TraktMediaEntity>> getWatchlist({
    TraktMediaType? type,
    TraktWatchlistSort sort = TraktWatchlistSort.rank,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final path =
        '/sync/watchlist${type != null ? '/${type.value}' : ''}/${sort.value}';

    return _client.get(
      path,
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      authenticated: true,
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktMediaEntity.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Add items to the user's watchlist.
  Future<TraktSyncResponse> addToWatchlist(TraktSyncRequest request) async {
    return _client.post(
      '/sync/watchlist',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove items from the user's watchlist.
  Future<TraktSyncResponse> removeFromWatchlist(
    TraktSyncRequest request,
  ) async {
    return _client.post(
      '/sync/watchlist/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Reorder items in the user's watchlist.
  Future<void> reorderWatchlist(List<int> rank) async {
    await _client.post(
      '/sync/watchlist/reorder',
      body: {'rank': rank},
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- RECOMMENDATIONS (Sync specific) ---

  /// [🔒 OAuth Required] Get the user's hidden recommendations.
  Future<TraktListResponse<TraktMediaEntity>> getRecommendations({
    TraktMediaType? type,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final path = '/sync/recommendations${type != null ? '/${type.value}' : ''}';

    return _client.get(
      path,
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      authenticated: true,
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktMediaEntity.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }
}
