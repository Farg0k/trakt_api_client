import '../core/trakt_comment_types.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_pagination_params.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import '../models/trakt_note.dart';
import '../models/trakt_media_entity.dart';
import '../models/trakt_media_state.dart';
import '../models/trakt_sync_models.dart';
import '../models/trakt_user.dart';
import '../models/trakt_user_models.dart';
import 'trakt_api_base.dart';

/// Access to user endpoints.
class UsersApi extends TraktApiBase {
  /// Creates a new [UsersApi] instance.
  UsersApi(super.client);

  // --- SETTINGS & FILTERS ---

  /// [🔒 OAuth Required] Get the user's settings.
  Future<TraktUserSettings> getSettings() async {
    return client.get(
      '/users/settings',
      authenticated: true,
      mapper: (body, headers) =>
          TraktUserSettings.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Get saved filters.
  Future<List<Map<String, dynamic>>> getSavedFilters({String? section}) async {
    return client.get(
      '/users/saved_filters${section != null ? '/$section' : ''}',
      authenticated: true,
      mapper: (body, headers) => List<Map<String, dynamic>>.from(body as List),
    );
  }

  // --- FOLLOW REQUESTS ---

  /// [🔒 OAuth Required] Get follower requests.
  Future<List<TraktFollowRequest>> getFollowRequests() async {
    return client.get(
      '/users/requests',
      authenticated: true,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktFollowRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Approve a follower request.
  Future<TraktUserConnection> approveFollowRequest(int requestId) async {
    return client.post(
      '/users/requests/$requestId',
      authenticated: true,
      mapper: (body, headers) =>
          TraktUserConnection.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Deny a follower request.
  Future<void> denyFollowRequest(int requestId) async {
    await client.delete(
      '/users/requests/$requestId',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- HIDDEN ITEMS ---

  /// [🔒 OAuth Required] Get hidden items.
  Future<TraktListResponse<TraktMediaEntity>> getHiddenItems(
    String section, {
    TraktMediaType? type,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{};
    if (type != null) queryParams['type'] = type.value;

    return getList(
      '/users/hidden/$section',
      pagination: pagination,
      extended: extended,
      queryParams: queryParams.isEmpty ? null : queryParams,
      mapper: (json) => TraktMediaEntity.fromJson(json),
    );
  }

  /// [🔒 OAuth Required] Add items to hidden list.
  Future<TraktSyncResponse> addHiddenItems(
      String section, TraktSyncRequest request) async {
    return client.post(
      '/users/hidden/$section',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Remove items from hidden list.
  Future<TraktSyncResponse> removeHiddenItems(
      String section, TraktSyncRequest request) async {
    return client.post(
      '/users/hidden/$section/remove',
      body: request.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  // --- LIKES ---

  /// Get user's likes.
  ///
  /// [username] can be a username or UUID.
  Future<TraktListResponse<dynamic>> getLikes(
    String username, {
    required String type,
    TraktPaginationParams? pagination,
  }) async {
    return getList(
      '/users/$username/likes/$type',
      pagination: pagination,
      mapper: (json) {
        if (type == 'comments') {
          return TraktComment.fromJson(json['comment'] as Map<String, dynamic>);
        } else {
          return TraktList.fromJson(json['list'] as Map<String, dynamic>);
        }
      },
    );
  }

  // --- PROFILE & SOCIAL ---

  /// Get a user's profile.
  ///
  /// [username] can be a username or UUID.
  Future<TraktUser> getProfile(String username,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return client.get(
      '/users/$username',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktUser.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get what a user is currently watching.
  ///
  /// [username] can be a username or UUID.
  Future<dynamic> getWatching(String username,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return client.get(
      '/users/$username/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) {
        if (body == null) return null;
        final json = body as Map<String, dynamic>;
        final type = json['type'] as String;
        if (type == 'movie') {
          return TraktMovie.fromJson(json['movie'] as Map<String, dynamic>);
        }
        if (type == 'episode') {
          return TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>);
        }
        return json;
      },
    );
  }

  /// Get user's comments.
  ///
  /// [username] can be a username or UUID.
  Future<TraktListResponse<TraktComment>> getComments(
    String username, {
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/users/$username/comments/${commentType.value}/${type.value}',
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktComment.fromJson(json),
    );
  }

  /// Get user's notes.
  ///
  /// [username] can be a username or UUID.
  Future<TraktListResponse<TraktNote>> getNotes(
    String username, {
    TraktMediaType? type,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/users/$username/notes${type != null ? '/${type.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) => TraktNote.fromJson(json),
    );
  }

  // --- COLLECTION, HISTORY, WATCHED, FAVORITES ---

  /// Get user's collection.
  ///
  /// [username] can be a username or UUID.
  Future<List<TraktMediaState<T>>> getCollection<T>(String username,
      {required TraktMediaType type,
      TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return client.get(
      '/users/$username/collection/${type.value}',
      queryParams: {'extended': extended.value},
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

  /// Get user's watch history.
  ///
  /// [username] can be a username or UUID.
  Future<TraktListResponse<TraktSyncHistory>> getHistory(
    String username, {
    TraktMediaType? type,
    int? id,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    var path = '/users/$username/history';
    if (type != null) {
      path += '/${type.value}';
      if (id != null) path += '/$id';
    }

    return getList(
      path,
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktSyncHistory.fromJson(json),
    );
  }

  /// Get user's watched items.
  ///
  /// [username] can be a username or UUID.
  Future<List<TraktMediaState<T>>> getWatched<T>(String username,
      {required TraktMediaType type,
      TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return client.get(
      '/users/$username/watched/${type.value}',
      queryParams: {'extended': extended.value},
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

  /// Get user's watchlist.
  ///
  /// [username] can be a username or UUID.
  Future<TraktListResponse<TraktMediaEntity>> getWatchlist(
    String username, {
    TraktMediaType? type,
    TraktWatchlistSort sort = TraktWatchlistSort.rank,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/users/$username/watchlist${type != null ? '/${type.value}' : ''}/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktMediaEntity.fromJson(json),
    );
  }

  /// Get user's favorites.
  ///
  /// [username] can be a username or UUID.
  Future<TraktListResponse<TraktMediaEntity>> getFavorites(
    String username, {
    TraktMediaType? type,
    TraktWatchlistSort sort = TraktWatchlistSort.rank,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/users/$username/favorites${type != null ? '/${type.value}' : ''}/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktMediaEntity.fromJson(json),
    );
  }

  // --- LISTS MANAGEMENT ---

  /// Get user's lists.
  ///
  /// [username] can be a username or UUID.
  Future<List<TraktList>> getLists(String username) async {
    return client.get(
      '/users/$username/lists',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Create a new list for the user.
  ///
  /// [username] can be a username or UUID.
  Future<TraktList> createList(String username, TraktList list) async {
    return client.post(
      '/users/$username/lists',
      body: list.toJson(),
      authenticated: true,
      mapper: (body, headers) =>
          TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Reorder lists for the user.
  ///
  /// [username] can be a username or UUID.
  Future<void> reorderLists(String username, List<int> rank) async {
    await client.post(
      '/users/$username/lists/reorder',
      body: {'rank': rank},
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Get items in a list.
  ///
  /// [username] can be a username or UUID.
  Future<List<TraktListItem>> getListItems(
    String username,
    String listId, {
    TraktMediaType? type,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{'extended': extended.value};
    if (type != null) queryParams['type'] = type.value;

    return client.get(
      '/users/$username/lists/$listId/items',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Reorder items in a list.
  ///
  /// [username] can be a username or UUID.
  Future<void> reorderListItems(
      String username, String listId, List<int> rank) async {
    await client.post(
      '/users/$username/lists/$listId/items/reorder',
      body: {'rank': rank},
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- SOCIAL ---

  /// [🔒 OAuth Required] Follow a user.
  ///
  /// [username] can be a username or UUID.
  Future<TraktUserConnection> follow(String username) async {
    return client.post(
      '/users/$username/follow',
      authenticated: true,
      mapper: (body, headers) =>
          TraktUserConnection.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Unfollow a user.
  ///
  /// [username] can be a username or UUID.
  Future<void> unfollow(String username) async {
    await client.delete(
      '/users/$username/follow',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Get user's friends.
  ///
  /// [username] can be a username or UUID.
  Future<List<TraktUserConnection>> getFriends(String username) async {
    return client.get(
      '/users/$username/friends',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUserConnection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // --- BLOCKING ---

  /// [🔒 OAuth Required] Get blocked users.
  Future<List<TraktUser>> getBlockedUsers() async {
    return client.get(
      '/users/block',
      authenticated: true,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUser.fromJson(e['user'] as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Block a user.
  ///
  /// [username] can be a username or UUID.
  Future<void> block(String username) async {
    await client.post(
      '/users/$username/block',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Unblock a user.
  ///
  /// [username] can be a username or UUID.
  Future<void> unblock(String username) async {
    await client.delete(
      '/users/$username/block',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- STATS & REPORT ---

  /// Get user stats.
  ///
  /// [username] can be a username or UUID.
  Future<TraktUserStats> getStats(String username) async {
    return client.get(
      '/users/$username/stats',
      mapper: (body, headers) =>
          TraktUserStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Report a user for inappropriate content.
  ///
  /// [username] can be a username or UUID.
  Future<void> report(String username,
      {required TraktReportReason reason, String? notes}) async {
    await client.post(
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
