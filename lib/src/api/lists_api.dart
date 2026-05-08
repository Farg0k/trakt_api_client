import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_list.dart';
import '../models/trakt_list_item.dart';
import '../models/trakt_user.dart';

class ListsApi {
  final TraktApiClient _client;

  ListsApi(this._client);

  /// Get trending lists.
  Future<TraktListResponse<TraktList>> getTrending({
    TraktListType? type,
    int page = 1,
    int limit = 10,
  }) async {
    final path = '/lists/trending${type != null ? '/${type.value}' : ''}';
    return _client.get(
      path,
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
    TraktListType? type,
    int page = 1,
    int limit = 10,
  }) async {
    final path = '/lists/popular${type != null ? '/${type.value}' : ''}';
    return _client.get(
      path,
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

  /// Get a single list by its ID.
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
  Future<TraktList> getSummary(String id) async {
    return _client.get(
      '/lists/$id',
      mapper: (body, headers) => TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get comments for a list.
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    TraktCommentSort sort = TraktCommentSort.newest,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/lists/$id/comments/${sort.value}',
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

  /// Get items for a list.
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
  Future<List<TraktListItem>> getItems(
    String id, {
    String? type,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{'extended': extended.value};
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
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
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

  /// [🔒 OAuth Required] Like a list.
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
  Future<void> like(String id) async {
    await _client.post(
      '/lists/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Remove a like from a list.
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
  Future<void> unlike(String id) async {
    await _client.delete(
      '/lists/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Report a list for inappropriate content.
  /// 
  /// [id] can be a Trakt ID or Trakt slug.
  Future<void> report(String id,
      {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/lists/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
