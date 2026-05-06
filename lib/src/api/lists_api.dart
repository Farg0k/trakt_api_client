import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_report_reason.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_list.dart';
import '../models/trakt_list_item.dart';
import '../models/trakt_user.dart';

class ListsApi {
  final TraktApiClient _client;

  ListsApi(this._client);

  /// Get trending lists.
  Future<TraktListResponse<TraktList>> getTrending({
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/lists/trending',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktList.fromJson(item['list'] as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get popular lists.
  Future<TraktListResponse<TraktList>> getPopular({
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/lists/popular',
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

  /// Get a single list by its ID.
  Future<TraktList> getSummary(String id) async {
    return _client.get(
      '/lists/$id',
      mapper: (body, headers) => TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get comments for a list.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/lists/$id/comments',
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

  /// Get items for a list.
  Future<List<TraktListItem>> getItems(
    String id, {
    String? type,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final queryParams = <String, String>{'extended': extended};
    if (type != null) queryParams['type'] = type;

    return _client.get(
      '/lists/$id/items',
      queryParams: queryParams,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktListItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get users who liked a list.
  Future<TraktListResponse<TraktUser>> getLikes(
    String id, {
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/lists/$id/likes',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktUser.fromJson(item['user'] as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Like a list.
  Future<void> like(String id) async {
    await _client.post(
      '/lists/$id/like',
      mapper: (body, headers) => null,
    );
  }

  /// Remove a like from a list.
  Future<void> unlike(String id) async {
    await _client.delete(
      '/lists/$id/like',
      mapper: (body, headers) => null,
    );
  }

  /// Report a list for inappropriate content.
  Future<void> report(String id,
      {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/lists/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      mapper: (body, headers) => null,
    );
  }
}
