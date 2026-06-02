import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_pagination_params.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_media_entity.dart';
import '../models/trakt_media_state.dart';
import '../models/trakt_sync_models.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_api_base.dart';

/// Access to sync endpoints.
class SyncApi extends TraktApiBase {
  /// Creates a new [SyncApi] instance.
  SyncApi(super.client);

  /// [🔒 OAuth Required] Get the last activities for the authenticated user.
  Future<TraktLastActivities> getLastActivities() async {
    return client.get(
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

    return client.get(
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
    return client.get(
      '/sync/playback/$id',
      authenticated: true,
      mapper: (body, headers) => body == null
          ? null
          : TraktSyncPlayback.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove a playback progress item.
  Future<void> removePlaybackProgress(int id) async {
    await client.delete(
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
    return client.get(
      '/sync/collection/${type.value}',
      queryParams: {'extended': extended.value},
      authenticated: true,
      mapper: (body, headers) {
        if (body == null) {
          return [];
        }
        
        final List<dynamic> list;
        if (body is List) {
          list = body;
        } else if (body is Map<String, dynamic>) {
          list = [body];
        } else {
          // Unexpected type, return empty list
          return [];
        }
        
        return list
            .where((e) => e != null && e is Map<String, dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((json) {
              if (type == TraktMediaType.movies) {
                return TraktMediaState<TraktMovie>.fromJson(
                    json, TraktMovie.fromJson, 'movie') as TraktMediaState<T>;
              } else {
                return TraktMediaState<TraktShow>.fromJson(
                    json, TraktShow.fromJson, 'show') as TraktMediaState<T>;
              }
            })
            .toList();
      },
    );
  }

  /// [🔒 OAuth Required] Add items to the user's collection.
  Future<TraktSyncResponse> addToCollection(TraktSyncRequest request) async {
    return client.post(
      '/sync/collection',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  /// [🔒 OAuth Required] Remove items from the user's collection.
  Future<TraktSyncResponse> removeFromCollection(
      TraktSyncRequest request) async {
    return client.post(
      '/sync/collection/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  // --- WATCHED ---

  /// [🔒 OAuth Required] Get the user's watched items.
  /// Returns all movies or shows a user has watched sorted by most recently watched.
  /// For shows, set [includeSeasons] to false to omit season and episode info (?extended=noseasons).
  Future<List<TraktMediaState<T>>> getWatched<T>({
    required TraktMediaType type,
    TraktExtendedInfo extended = TraktExtendedInfo.metadata,
    bool includeSeasons = true,
  }) async {
    var params = {'extended': extended.value};
    if (type == TraktMediaType.shows && !includeSeasons) {
      params['extended'] = 'noseasons';
    }
    return client.get(
      '/sync/watched/${type.value}',
      queryParams: params,
      authenticated: true,
      mapper: (body, headers) {
        if (body == null) {
          return [];
        }
        
        final List<dynamic> list;
        if (body is List) {
          list = body;
        } else if (body is Map<String, dynamic>) {
          list = [body];
        } else {
          // Unexpected type, return empty list
          return [];
        }
        
        return list
            .where((e) => e != null && e is Map<String, dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .map((json) {
              if (type == TraktMediaType.movies) {
                return TraktMediaState<TraktMovie>.fromJson(
                    json, TraktMovie.fromJson, 'movie') as TraktMediaState<T>;
              } else {
                return TraktMediaState<TraktShow>.fromJson(
                    json, TraktShow.fromJson, 'show') as TraktMediaState<T>;
              }
            })
            .toList();
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
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    var path = '/sync/history';
    if (type != null) {
      path += '/${type.value}';
      if (id != null) path += '/$id';
    }

    final queryParams = <String, String>{};
    if (startAt != null) {
      queryParams['start_at'] = TraktDateUtils.formatFullDate(startAt);
    }
    if (endAt != null) {
      queryParams['end_at'] = TraktDateUtils.formatFullDate(endAt);
    }

    return getList(
      path,
      authenticated: true,
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktSyncHistory.fromJson(json),
    );
  }


  /// [🔒 OAuth Required] Add items to the user's watch history.
  Future<TraktSyncResponse> addToHistory(TraktSyncRequest request) async {
    return client.post(
      '/sync/history',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  /// [🔒 OAuth Required] Remove items from the user's watch history.
  Future<TraktSyncResponse> removeFromHistory(TraktSyncRequest request) async {
    return client.post(
      '/sync/history/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
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

    return client.get(
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
    return client.post(
      '/sync/ratings',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  /// [🔒 OAuth Required] Remove ratings from items.
  Future<TraktSyncResponse> removeRatings(TraktSyncRequest request) async {
    return client.post(
      '/sync/ratings/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  // --- WATCHLIST ---

  /// [🔒 OAuth Required] Get the user's watchlist.
  Future<TraktListResponse<TraktMediaEntity>> getWatchlist({
    TraktMediaType? type,
    TraktWatchlistSort sort = TraktWatchlistSort.rank,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final path =
        '/sync/watchlist${type != null ? '/${type.value}' : ''}/${sort.value}';

    return getList(
      path,
      authenticated: true,
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktMediaEntity.fromJson(json),
    );
  }

  /// [🔒 OAuth Required] Add items to the user's watchlist.
  Future<TraktSyncResponse> addToWatchlist(TraktSyncRequest request) async {
    return client.post(
      '/sync/watchlist',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  /// [🔒 OAuth Required] Remove items from the user's watchlist.
  Future<TraktSyncResponse> removeFromWatchlist(
      TraktSyncRequest request) async {
    return client.post(
      '/sync/watchlist/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(
          body as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  /// [🔒 OAuth Required] Reorder items in the user's watchlist.
  Future<void> reorderWatchlist(List<int> rank) async {
    await client.post(
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
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final path = '/sync/recommendations${type != null ? '/${type.value}' : ''}';

    return getList(
      path,
      authenticated: true,
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktMediaEntity.fromJson(json),
    );
  }
}

