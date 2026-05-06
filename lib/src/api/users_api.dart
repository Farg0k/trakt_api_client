import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_list.dart';
import '../models/trakt_list_item.dart';
import '../models/trakt_search_result.dart';
import '../models/trakt_sync_models.dart';
import '../models/trakt_user.dart';
import '../models/trakt_user_models.dart';

class UsersApi {
  final TraktApiClient _client;

  UsersApi(this._client);

  /// Get the user's settings.
  Future<TraktUserSettings> getSettings() async {
    return _client.get(
      '/users/settings',
      mapper: (body, headers) => TraktUserSettings.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get follower requests.
  Future<List<TraktFollowRequest>> getFollowRequests() async {
    return _client.get(
      '/users/requests',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktFollowRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Approve a follower request.
  Future<TraktUserConnection> approveFollowRequest(int requestId) async {
    return _client.post(
      '/users/requests/$requestId',
      mapper: (body, headers) => TraktUserConnection.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Deny a follower request.
  Future<void> denyFollowRequest(int requestId) async {
    await _client.delete(
      '/users/requests/$requestId',
      mapper: (body, headers) => null,
    );
  }

  /// Get a user's profile.
  Future<TraktUser> getProfile(String username, {String extended = TraktExtendedInfo.metadata}) async {
    return _client.get(
      '/users/$username',
      queryParams: {'extended': extended},
      mapper: (body, headers) => TraktUser.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get a user's collection.
  Future<List<dynamic>> getCollection(String username, {required String type, String extended = TraktExtendedInfo.metadata}) async {
    return _client.get(
      '/users/$username/collection/$type',
      queryParams: {'extended': extended},
      mapper: (body, headers) => body as List,
    );
  }

  /// Get a user's watch history.
  Future<TraktListResponse<TraktSyncHistory>> getHistory(
    String username, {
    String? type,
    int? id,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    var path = '/users/$username/history';
    if (type != null) {
      path += '/$type';
      if (id != null) path += '/$id';
    }

    return _client.get(
      path,
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
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

  /// Get a user's personal lists.
  Future<List<TraktList>> getLists(String username) async {
    return _client.get(
      '/users/$username/lists',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Create a new personal list.
  Future<TraktList> createList(String username, TraktList list) async {
    return _client.post(
      '/users/$username/lists',
      body: list.toJson(),
      mapper: (body, headers) => TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Update a personal list.
  Future<TraktList> updateList(String username, String listId, TraktList list) async {
    return _client.put(
      '/users/$username/lists/$listId',
      body: list.toJson(),
      mapper: (body, headers) => TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Delete a personal list.
  Future<void> deleteList(String username, String listId) async {
    await _client.delete(
      '/users/$username/lists/$listId',
      mapper: (body, headers) => null,
    );
  }

  /// Get items in a personal list.
  Future<List<TraktListItem>> getListItems(
    String username,
    String listId, {
    String? type,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final queryParams = <String, String>{'extended': extended};
    if (type != null) queryParams['type'] = type;

    return _client.get(
      '/users/$username/lists/$listId/items',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((e) => TraktListItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Add items to a personal list.
  Future<TraktSyncResponse> addListItems(String username, String listId, TraktSyncRequest request) async {
    return _client.post(
      '/users/$username/lists/$listId/items',
      body: request.toJson(),
      mapper: (body, headers) => TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Remove items from a personal list.
  Future<TraktSyncResponse> removeListItems(String username, String listId, TraktSyncRequest request) async {
    return _client.post(
      '/users/$username/lists/$listId/items/remove',
      body: request.toJson(),
      mapper: (body, headers) => TraktSyncResponse.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Follow a user.
  Future<TraktUserConnection> follow(String username) async {
    return _client.post(
      '/users/$username/follow',
      mapper: (body, headers) => TraktUserConnection.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Unfollow a user.
  Future<void> unfollow(String username) async {
    await _client.delete(
      '/users/$username/follow',
      mapper: (body, headers) => null,
    );
  }

  /// Get a user's followers.
  Future<List<TraktUserConnection>> getFollowers(String username) async {
    return _client.get(
      '/users/$username/followers',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUserConnection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get users a user is following.
  Future<List<TraktUserConnection>> getFollowing(String username) async {
    return _client.get(
      '/users/$username/following',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUserConnection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get a user's friends.
  Future<List<TraktUserConnection>> getFriends(String username) async {
    return _client.get(
      '/users/$username/friends',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktUserConnection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get a user's statistics.
  Future<TraktUserStats> getStats(String username) async {
    return _client.get(
      '/users/$username/stats',
      mapper: (body, headers) => TraktUserStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get a user's watchlist.
  Future<TraktListResponse<TraktSearchResult>> getWatchlist(
    String username, {
    String sort = 'rank',
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/users/$username/watchlist/$sort',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
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
}
