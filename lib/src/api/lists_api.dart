import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_pagination_params.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_list.dart';
import '../models/trakt_user.dart';
import 'trakt_api_base.dart';

/// Access to list endpoints.
class ListsApi extends TraktApiBase {
  /// Creates a new [ListsApi] instance.
  ListsApi(super.client);

  /// Get trending lists.
  Future<TraktListResponse<TraktList>> getTrending({
    TraktListType? type,
    TraktPaginationParams? pagination,
  }) async {
    final path = '/lists/trending${type != null ? '/${type.value}' : ''}';
    return getList(
      path,
      pagination: pagination,
      mapper: (json) => TraktList.fromJson(json['list'] as Map<String, dynamic>),
    );
  }

  /// Get popular lists.
  Future<TraktListResponse<TraktList>> getPopular({
    TraktListType? type,
    TraktPaginationParams? pagination,
  }) async {
    final path = '/lists/popular${type != null ? '/${type.value}' : ''}';
    return getList(
      path,
      pagination: pagination,
      mapper: (json) => TraktList.fromJson(json['list'] as Map<String, dynamic>),
    );
  }

  /// Get a single list by its ID.
  ///
  /// [id] can be a Trakt ID or Trakt slug.
  Future<TraktList> getSummary(String id) async {
    return client.get(
      '/lists/$id',
      mapper: (body, headers) =>
          TraktList.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get comments for a list.
  ///
  /// [id] can be a Trakt ID or Trakt slug.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    TraktCommentSort sort = TraktCommentSort.newest,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/lists/$id/comments/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktComment.fromJson(json),
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

    return client.get(
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
    TraktPaginationParams? pagination,
  }) async {
    return getList(
      '/lists/$id/likes',
      pagination: pagination,
      mapper: (json) => TraktUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Like a list.
  ///
  /// [id] can be a Trakt ID or Trakt slug.
  Future<void> like(String id) async {
    await client.post(
      '/lists/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Remove a like from a list.
  ///
  /// [id] can be a Trakt ID or Trakt slug.
  Future<void> unlike(String id) async {
    await client.delete(
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
    await client.post(
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

