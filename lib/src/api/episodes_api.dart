import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_media_models.dart';
import '../models/trakt_generic_models.dart';
import '../models/trakt_stats.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_api_base.dart';

/// Access to episode endpoints.
class EpisodesApi extends TraktApiBase {
  /// Creates a new [EpisodesApi] instance.
  EpisodesApi(super.client);

  /// Get detailed episode information.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktEpisode> getSummary(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktEpisode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all title aliases for an episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMediaAlias>> getAliases(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/aliases',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktMediaAlias.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all translations for an episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktTranslation>> getTranslations(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    String? language,
  }) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/translations${language != null ? '/$language' : ''}',
      mapper: (body, headers) => (body as List)
          .map(
            (item) => TraktTranslation.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  /// Get all comments for an episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktComment>> getComments(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktCommentSort sort = TraktCommentSort.newest,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/comments/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: TraktComment.fromJson,
    );
  }

  /// Get all lists that contain this episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    TraktPaginationParams? pagination,
  }) async {
    return getList(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/lists/${type.value}/${sort.value}',
      pagination: pagination,
      mapper: TraktList.fromJson,
    );
  }

  /// Get rating distribution for an episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktRating> getRatings(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/ratings',
      mapper: (body, headers) =>
          TraktRating.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get episode stats.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktStats> getStats(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/stats',
      mapper: (body, headers) =>
          TraktStats.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get users currently watching an episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktUser>> getWatching(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/watching',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => (body as List)
          .map((item) => TraktUser.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get all videos for an episode.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktVideo>> getVideos(
    String showId,
    int seasonNumber,
    int episodeNumber,
  ) async {
    return client.get(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/videos',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktVideo.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get recently updated episodes.
  Future<TraktListResponse<TraktMetadata<TraktEpisode>>> getUpdates(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/episodes/updates/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktEpisode.fromJson, 'episode'),
    );
  }

  /// Get recently updated episode IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    TraktPaginationParams? pagination,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/episodes/updates/id/$dateStr',
      pagination: pagination,
      mapper: (json) => json as int,
    );
  }

  /// Get recently deleted episodes.
  Future<TraktListResponse<TraktMetadata<TraktEpisode>>> getDeleted(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/episodes/updates/deleted/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktEpisode.fromJson, 'episode'),
    );
  }

  /// 🔒 OAuth Required Report an episode for inappropriate content.
  ///
  /// [showId] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(
    String showId,
    int seasonNumber,
    int episodeNumber, {
    required TraktReportReason reason,
    String? notes,
  }) async {
    await client.post(
      '/shows/$showId/seasons/$seasonNumber/episodes/$episodeNumber/report',
      body: {'reason': reason.value, 'notes': notes}
        ..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
