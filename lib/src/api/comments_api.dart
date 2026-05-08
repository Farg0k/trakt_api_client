import '../core/trakt_api_client.dart';
import '../core/trakt_comment_types.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_report_reason.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import '../models/trakt_season.dart';
import '../models/trakt_list.dart';
import '../models/trakt_user.dart';

class CommentsApi {
  final TraktApiClient _client;

  CommentsApi(this._client);

  /// [🔒 OAuth Required] Post a new comment to a movie, show, season, episode, or list.
  Future<TraktComment> post({
    required String comment,
    TraktMovie? movie,
    TraktShow? show,
    TraktSeason? season,
    TraktEpisode? episode,
    TraktList? list,
    bool spoiler = false,
  }) async {
    return _client.post(
      '/comments',
      body: {
        'comment': comment,
        'spoiler': spoiler,
        if (movie != null) 'movie': {'ids': movie.ids?.toJson()},
        if (show != null) 'show': {'ids': show.ids?.toJson()},
        if (season != null) 'season': {'ids': season.ids?.toJson()},
        if (episode != null) 'episode': {'ids': episode.ids?.toJson()},
        if (list != null) 'list': {'ids': list.ids?.toJson()},
      },
      authenticated: true,
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get a single comment by its ID.
  Future<TraktComment> get(int id) async {
    return _client.get(
      '/comments/$id',
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Update an existing comment.
  Future<TraktComment> update(int id,
      {required String comment, bool spoiler = false}) async {
    return _client.put(
      '/comments/$id',
      body: {'comment': comment, 'spoiler': spoiler},
      authenticated: true,
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Delete a comment.
  Future<void> delete(int id) async {
    await _client.delete(
      '/comments/$id',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Get replies for a comment.
  Future<List<TraktComment>> getReplies(int id) async {
    return _client.get(
      '/comments/$id/replies',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktComment.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// [🔒 OAuth Required] Post a reply to a comment.
  Future<TraktComment> postReply(int id,
      {required String comment, bool spoiler = false}) async {
    return _client.post(
      '/comments/$id/replies',
      body: {'comment': comment, 'spoiler': spoiler},
      authenticated: true,
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users who liked a comment.
  Future<TraktListResponse<TraktUser>> getLikes(int id,
      {int page = 1, int limit = 10}) async {
    return _client.get(
      '/comments/$id/likes',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktUser.fromJson(item['user'] as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Like a comment.
  Future<void> like(int id) async {
    await _client.post(
      '/comments/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Remove a like from a comment.
  Future<void> unlike(int id) async {
    await _client.delete(
      '/comments/$id/like',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Report a comment for inappropriate content.
  Future<void> report(int id,
      {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/comments/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Get trending comments.
  Future<TraktListResponse<TraktComment>> getTrending({
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _getCommentList(
        '/comments/trending', commentType, type, page, limit, extended);
  }

  /// Get recent comments.
  Future<TraktListResponse<TraktComment>> getRecent({
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _getCommentList(
        '/comments/recent', commentType, type, page, limit, extended);
  }

  /// Get recently updated comments.
  Future<TraktListResponse<TraktComment>> getUpdates({
    TraktCommentType commentType = TraktCommentType.all,
    TraktMediaType type = TraktMediaType.all,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _getCommentList(
        '/comments/updates', commentType, type, page, limit, extended);
  }

  /// Get the object the comment is attached to.
  ///
  /// Returns a dynamic object which can be [TraktMovie], [TraktShow],
  /// [TraktSeason], [TraktEpisode], or [TraktList].
  Future<dynamic> getAttachedMedia(int id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return _client.get(
      '/comments/$id/attached_media',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) {
        final Map<String, dynamic> json = body as Map<String, dynamic>;
        final String type = json['type'] as String;
        final data = json[type] as Map<String, dynamic>;

        switch (type) {
          case 'movie':
            return TraktMovie.fromJson(data);
          case 'show':
            return TraktShow.fromJson(data);
          case 'season':
            return TraktSeason.fromJson(data);
          case 'episode':
            return TraktEpisode.fromJson(data);
          case 'list':
            return TraktList.fromJson(data);
          default:
            return data;
        }
      },
    );
  }

  Future<TraktListResponse<TraktComment>> _getCommentList(
    String path,
    TraktCommentType commentType,
    TraktMediaType type,
    int page,
    int limit,
    TraktExtendedInfo extended,
  ) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
      'comment_type': commentType.value,
      'type': type.value,
    };

    return _client.get(
      path,
      queryParams: queryParams,
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
}
