import '../core/trakt_api_client.dart';
import '../core/trakt_comment_types.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_collected_item.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_list_item.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_note.dart';
import '../models/trakt_search_result.dart';
import '../models/trakt_sync_models.dart';
import '../models/trakt_user.dart';
import '../models/trakt_user_models.dart';
import '../models/trakt_watched_item.dart';

class UsersApi {
  final TraktApiClient _client;

  UsersApi(this._client);

  // --- SETTINGS & FILTERS ---

  /// [🔒 OAuth Required] Get the user's settings.
  Future<TraktUserSettings> getSettings() async {
    return _client.get(
      '/users/settings',
      authenticated: true,
      mapper: (body, headers) => TraktUserSettings.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Get saved filters.
  Future<List<Map<String, dynamic>>> getSavedFilters({String? section}) async {
    return _client.get(
      '/users/saved_filters${section != null ? '/$section' : ''}',
      authenticated: true,
      mapper: (body, headers) => List<Map<String, dynamic>>.from(body as List),
    );
  }

  // --- FOLLOW REQUESTS ---

  /// [🔒 OAuth Required] Get follower requests.
  Future<List<TraktFollowRequest>> getFollowRequests() async {
    return _client.get(
      '/users/requests',
      authenticated: true,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktFollowRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Approve a follower request.
  Future<TraktUserConnection> approveFollowRequest(int requestId) async {
    return _client.post(
      '/users/requests/$requestId',
      authenticated: true,
      mapper: (body, headers) => TraktUserConnection.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Deny a follower request.
  Future<void> denyFollowRequest(int requestId) async {
    await _client.delete(
      '/users/requests/$requestId',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- HIDDEN ITEMS ---

  /// [🔒 OAuth Required] Get hidden items.
  Future<TraktListResponse<TraktSearchResult>> getHiddenItems(
    String section, {
    TraktMediaType? type,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
    };
    if (type != null) queryParams['type'] = type.value;

    return _client.get(
      '/users/hidden/$section',
      queryParams: queryParams,
      authenticated: true,
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktSearchResult.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Add items to hidden list.
  Future<TraktSyncResponse> addHiddenItems(String section, TraktSyncRequest request) async {
    return _client.post(
      '/users/hidden/$section',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove items from hidden list.
  Future<TraktSyncResponse> removeHiddenItems(String section, TraktSyncRequest request) async {
    return _client.post(
      '/users/hidden/$section/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  // --- LIKES ---

  /// Get user's likes.
  Future<TraktListResponse<dynamic>> getLikes(
    String username, {
    required String type,
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/users/$username/likes/$type',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List).map((e) {
          final json = e as Map<String, dynamic>;
          if (type == 'comments') {
            return TraktComment.fromJson(json['comment'] as Map<String, dynamic>);
          } else {
            return TraktList.fromJson(json['list'] as Map<String, dynamic>);
          }
        }).toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  // --- PROFILE & SOCIAL ---

  /// Get a user's profile.
  Future<TraktUser> getProfile(String username, {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/users/$username',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => TraktUser.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get what a user is currently watching.
  Future<dynamic> getWatching(String username, {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/users/$username/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) {
        if (body == null) return null;
        final json = body as Map<String, dynamic>;
        final type = json['type'] as String;
        if (type == 'movie') return TraktMovie.fromJson(json['movie'] as Map<String, dynamic>);
        if (type == 'episode') return TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>);
        return json;
      },
    );
  }

  /// Get user's comments.
  Future<TraktListResponse<TraktComment>> getComments(
    String username, {
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/users/$username/comments/${commentType.value}/${type.value}',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktComment.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get user's notes.
  Future<TraktListResponse<TraktNote>> getNotes(
    String username, {
    TraktMediaType? type,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
    };
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/users/$username/notes${type != null ? '/${type.value}' : ''}',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktNote.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  // --- COLLECTION, HISTORY, WATCHED, FAVORITES ---

  Future<List<T>> getCollection<T>(String username, {required TraktMediaType type, TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/users/$username/collection/${type.value}',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) {
        final list = body as List;
        if (type == TraktMediaType.movies) {
          return list.map((e) => TraktCollectedMovie.fromJson(e as Map<String, dynamic>) as T).toList();
        } else {
          return list.map((e) => TraktCollectedShow.fromJson(e as Map<String, dynamic>) as T).toList();
        }
      },
    );
  }

  Future<TraktListResponse<TraktSyncHistory>> getHistory(
    String username, {
    TraktMediaType? type,
    int? id,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    var path = '/users/$username/history';
    if (type != null) {
      path += '/${type.value}';
      if (id != null) path += '/$id';
    }

    return _client.get(
      path,
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
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

  Future<List<T>> getWatched<T>(String username, {required TraktMediaType type, TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/users/$username/watched/${type.value}',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) {
        final list = body as List;
        if (type == TraktMediaType.movies) {
          return list.map((e) => TraktWatchedMovie.fromJson(e as Map<String, dynamic>) as T).toList();
        } else {
          return list.map((e) => TraktWatchedShow.fromJson(e as Map<String, dynamic>) as T).toList();
        }
      },
    );
  }

  Future<TraktListResponse<TraktSearchResult>> getWatchlist(
    String username, {
    TraktMediaType? type,
    TraktWatchlistSort sort = TraktWatchlistSort.rank,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/users/$username/watchlist${type != null ? '/${type.value}' : ''}/${sort.value}',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktSearchResult.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  Future<TraktListResponse<TraktSearchResult>> getFavorites(
    String username, {
    TraktMediaType? type,
    TraktWatchlistSort sort = TraktWatchlistSort.rank,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/users/$username/favorites${type != null ? '/${type.value}' : ''}/${sort.value}',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((e) => TraktSearchResult.fromJson(e as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  // --- LISTS MANAGEMENT ---

  Future<List<TraktList>> getLists(String username) async {
    return _client.get(
      '/users/$username/lists',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Create a new list for the user.
  Future<TraktList> createList(String username, TraktList list) async {
    return _client.post(
      '/users/$username/lists',
      body: list.toJson(),
      authenticated: true,
      mapper: (body, headers) => TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Reorder lists for the user.
  Future<void> reorderLists(String username, List<int> rank) async {
    await _client.post(
      '/users/$username/lists/reorder',
      body: {'rank': rank},
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  Future<List<TraktListItem>> getListItems(
    String username,
    String listId, {
    TraktMediaType? type,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{'extended': extended.value};
    if (type != null) queryParams['type'] = type.value;

    return _client.get(
      '/users/$username/lists/$listId/items',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Reorder items in a list.
  Future<void> reorderListItems(String username, String listId, List<int> rank) async {
    await _client.post(
      '/users/$username/lists/$listId/items/reorder',
      body: {'rank': rank},
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- SOCIAL ---

  /// [🔒 OAuth Required] Follow a user.
  Future<TraktUserConnection> follow(String username) async {
    return _client.post(
      '/users/$username/follow',
      authenticated: true,
      mapper: (body, headers) => TraktUserConnection.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Unfollow a user.
  Future<void> unfollow(String username) async {
    await _client.delete(
      '/users/$username/follow',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  Future<List<TraktUserConnection>> getFriends(String username) async {
    return _client.get(
      '/users/$username/friends',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUserConnection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // --- BLOCKING ---

  /// [🔒 OAuth Required] Get blocked users.
  Future<List<TraktUser>> getBlockedUsers() async {
    return _client.get(
      '/users/block',
      authenticated: true,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUser.fromJson(e['user'] as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Block a user.
  Future<void> block(String username) async {
    await _client.post(
      '/users/$username/block',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Unblock a user.
  Future<void> unblock(String username) async {
    await _client.delete(
      '/users/$username/block',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- STATS & REPORT ---

  Future<TraktUserStats> getStats(String username) async {
    return _client.get(
      '/users/$username/stats',
      mapper: (body, headers) => TraktUserStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Report a user for inappropriate content.
  Future<void> report(String username, {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/users/$username/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
