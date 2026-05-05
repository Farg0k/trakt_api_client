import '../core/trakt_api_client.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_movie.dart';
import '../models/trakt_show.dart';
import '../models/trakt_episode.dart';

class CommentsApi {
  final TraktApiClient _client;

  CommentsApi(this._client);

  /// Post a new comment to a movie, show, or episode.
  Future<TraktComment> post({
    required String comment,
    TraktMovie? movie,
    TraktShow? show,
    TraktEpisode? episode,
    bool spoiler = false,
  }) async {
    return _client.post(
      '/comments',
      body: {
        'comment': comment,
        'spoiler': spoiler,
        if (movie != null) 'movie': {'ids': movie.ids?.toJson()},
        if (show != null) 'show': {'ids': show.ids?.toJson()},
        if (episode != null) 'episode': {'ids': episode.ids?.toJson()},
      },
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

  /// Update an existing comment.
  Future<TraktComment> update(int id, {required String comment, bool spoiler = false}) async {
    // We need a PUT method in the client, but let's assume we use post or add put
    // For now I'll use a generic request method if I add it, or just use post if it supports PUT via headers
    // Actually Trakt uses PUT for updates. I should add PUT to TraktApiClient.
    return _client.put(
      '/comments/$id',
      body: {'comment': comment, 'spoiler': spoiler},
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Delete a comment.
  Future<void> delete(int id) async {
    await _client.delete(
      '/comments/$id',
      mapper: (body, headers) => null,
    );
  }

  /// Like a comment.
  Future<void> like(int id) async {
    await _client.post(
      '/comments/$id/like',
      mapper: (body, headers) => null,
    );
  }

  /// Remove a like from a comment.
  Future<void> unlike(int id) async {
    await _client.delete(
      '/comments/$id/like',
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

  /// Post a reply to a comment.
  Future<TraktComment> postReply(int id, {required String comment, bool spoiler = false}) async {
    return _client.post(
      '/comments/$id/replies',
      body: {'comment': comment, 'spoiler': spoiler},
      mapper: (body, headers) =>
          TraktComment.fromJson(body as Map<String, dynamic>),
    );
  }
}
