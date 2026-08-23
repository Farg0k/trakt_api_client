import '../core/trakt_comment_types.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_pagination_params.dart';
import '../core/trakt_media_type.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_media_entity.dart';
import '../models/trakt_sharing.dart';
import '../models/trakt_user.dart';
import 'trakt_api_base.dart';

/// Access to comment endpoints.
class CommentsApi extends TraktApiBase {
  /// Creates a new [CommentsApi] instance.
  CommentsApi(super.client);

  // --- ACTIONS ---

  /// 🔒 OAuth Required Post a new comment.
  Future<TraktComment> post(
    String comment, {
    bool spoiler = false,
    TraktSharing? sharing,
    TraktMediaEntity? item,
  }) async {
    return client.post(
      '/comments',
      authenticated: true,
      body: {
        'comment': comment,
        'spoiler': spoiler,
        if (sharing != null) 'sharing': sharing.toJson(),
        if (item != null) item.type: {'ids': _extractIds(item)},
      },
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get a single comment by its ID.
  Future<TraktComment> get(int id) async {
    return client.get(
      '/comments/$id',
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// 🔒 OAuth Required Update an existing comment.
  Future<TraktComment> update(
    int id,
    String comment, {
    bool spoiler = false,
  }) async {
    return client.put(
      '/comments/$id',
      authenticated: true,
      body: {'comment': comment, 'spoiler': spoiler},
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// 🔒 OAuth Required Delete a comment.
  Future<void> delete(int id) async {
    await client.delete(
      '/comments/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  // --- REPLIES ---

  /// Get replies for a comment.
  Future<List<TraktComment>> getReplies(int id) async {
    return client.get(
      '/comments/$id/replies',
      mapper: (body, headers) => (body as List)
          .map((e) => TraktComment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // --- LIKES ---

  /// 🔒 OAuth Required Like a comment.
  Future<void> like(int id) async {
    await client.post(
      '/comments/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// 🔒 OAuth Required Remove a like from a comment.
  Future<void> unlike(int id) async {
    await client.delete(
      '/comments/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Get users who liked a comment.
  Future<TraktListResponse<TraktUser>> getLikes(
    int id, {
    TraktPaginationParams? pagination,
  }) async {
    return getList(
      '/comments/$id/likes',
      pagination: pagination,
      mapper: (json) =>
          TraktUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  // --- TRENDING / RECENT ---

  /// Get trending comments.
  Future<TraktListResponse<TraktComment>> getTrending({
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    bool includeReplies = false,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.getList(
      '/comments/trending/${commentType.value}/${type.value}',
      pagination: pagination,
      queryParams: {
        'include_replies': includeReplies.toString(),
        'extended': extended.value,
      },
      mapper: (json) =>
          TraktComment.fromJson(json['comment'] as Map<String, dynamic>),
    );
  }

  /// Get recent comments.
  Future<TraktListResponse<TraktComment>> getRecent({
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    bool includeReplies = false,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.getList(
      '/comments/recent/${commentType.value}/${type.value}',
      pagination: pagination,
      queryParams: {
        'include_replies': includeReplies.toString(),
        'extended': extended.value,
      },
      mapper: (json) =>
          TraktComment.fromJson(json['comment'] as Map<String, dynamic>),
    );
  }

  /// Get most updated comments.
  Future<TraktListResponse<TraktComment>> getUpdates({
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    bool includeReplies = false,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.getList(
      '/comments/updates/${commentType.value}/${type.value}',
      pagination: pagination,
      queryParams: {
        'include_replies': includeReplies.toString(),
        'extended': extended.value,
      },
      mapper: (json) =>
          TraktComment.fromJson(json['comment'] as Map<String, dynamic>),
    );
  }

  // --- ITEM DETAILS ---

  /// Get comments for an object (movie, show, season, episode, list).
  Future<TraktListResponse<TraktComment>> getItemComments(
    TraktMediaEntity item, {
    TraktCommentSort sort = TraktCommentSort.newest,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    String path = '';
    switch (item.type) {
      case 'movie':
        path = '/movies/${item.movie?.ids?.trakt}/comments';
      case 'show':
        path = '/shows/${item.show?.ids?.trakt}/comments';
      case 'season':
        path =
            '/shows/${item.show?.ids?.trakt}/seasons/${item.season?.number}/comments';
      case 'episode':
        path =
            '/shows/${item.show?.ids?.trakt}/seasons/${item.episode?.season}/episodes/${item.episode?.number}/comments';
      case 'list':
        path = '/lists/${item.list?.ids?.trakt}/comments';
    }

    return getList(
      '$path/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: (json) => TraktComment.fromJson(json),
    );
  }

  Map<String, dynamic>? _extractIds(TraktMediaEntity item) {
    if (item.movie != null) return item.movie!.ids?.toJson();
    if (item.show != null) return item.show!.ids?.toJson();
    if (item.episode != null) return item.episode!.ids?.toJson();
    if (item.season != null) return item.season!.ids?.toJson();
    if (item.person != null) return item.person!.ids?.toJson();
    return null;
  }
}
