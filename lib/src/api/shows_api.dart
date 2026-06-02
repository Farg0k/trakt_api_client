import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_period.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_comment.dart';
import '../models/trakt_episode.dart';
import '../models/trakt_list.dart';
import '../models/trakt_show.dart';
import '../models/trakt_show_progress.dart';
import '../models/trakt_media_models.dart';
import '../models/trakt_generic_models.dart';
import '../models/trakt_stats.dart';
import '../models/trakt_user.dart';
import '../models/trakt_video.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_api_base.dart';

/// Access to show endpoints.
class ShowsApi extends TraktApiBase {
  /// Creates a new [ShowsApi] instance.
  ShowsApi(super.client);

  /// Get trending shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getTrending({
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/trending',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get popular shows.
  Future<TraktListResponse<TraktShow>> getPopular({
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/shows/popular',
      pagination: pagination,
      extended: extended,
      mapper: TraktShow.fromJson,
    );
  }

  /// Get recommended shows.
  Future<TraktListResponse<TraktShow>> getRecommended({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/recommended${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) => TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }

  /// Get most played shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getPlayed({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/played${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get most watched shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getWatched({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/watched${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get most collected shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getCollected({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/collected${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get most anticipated shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getAnticipated({
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/anticipated',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get most favorited shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getFavorited({
    TraktPeriod? period,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
  }) async {
    return getList(
      '/shows/favorited${period != null ? '/${period.value}' : ''}',
      pagination: pagination,
      extended: extended,
      filters: filters,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get recently updated shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getUpdates(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/shows/updates/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

  /// Get recently updated show IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    TraktPaginationParams? pagination,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/shows/updates/id/$dateStr',
      pagination: pagination,
      mapper: (json) => json as int,
    );
  }

  /// Get recently deleted shows.
  Future<TraktListResponse<TraktMetadata<TraktShow>>> getDeleted(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/shows/updates/deleted/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktShow.fromJson, 'show'),
    );
  }

    /// Get detailed show information.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<TraktShow> getSummary(
      String id, {
      TraktExtendedInfo extended = TraktExtendedInfo.full,
    }) async {
      return client.get(
        '/shows/$id',
        queryParams: {'extended': extended.value},
        mapper: (body, headers) {
          final Map<String, dynamic> json = body ?? <String, dynamic>{};
          return TraktShow.fromJson(json);
        },
      );
    }

    /// Get all title aliases for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<TraktMediaAlias>> getAliases(String id) async {
      return client.get(
        '/shows/$id/aliases',
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .map(TraktMediaAlias.fromJson)
              .toList();
        },
      );
    }

    /// Get all certifications for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<TraktMediaCertification>> getCertifications(String id) async {
      return client.get(
        '/shows/$id/certifications',
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .map(TraktMediaCertification.fromJson)
              .toList();
        },
      );
    }

    /// Get all languages for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<String>> getLanguages(String id) async {
      return client.get(
        '/shows/$id/languages',
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((e) => e != null && e is String)
              .map((e) => e as String)
              .toList();
        },
      );
    }

    /// Get all translations for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<TraktTranslation>> getTranslations(String id,
        {String? language}) async {
      return client.get(
        '/shows/$id/translations${language != null ? '/$language' : ''}',
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .map(TraktTranslation.fromJson)
              .toList();
        },
      );
    }

  /// Get all comments for a show.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktComment>> getComments(
    String id, {
    TraktCommentSort sort = TraktCommentSort.newest,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/shows/$id/comments/${sort.value}',
      pagination: pagination,
      extended: extended,
      mapper: TraktComment.fromJson,
    );
  }

  /// Get all lists that contain this show.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String id, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    TraktPaginationParams? pagination,
  }) async {
    return getList(
      '/shows/$id/lists/${type.value}/${sort.value}',
      pagination: pagination,
      mapper: TraktList.fromJson,
    );
  }

    /// Get all cast and crew for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<TraktCredits> getPeople(String id,
        {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
      return client.get(
        '/shows/$id/people',
        queryParams: {'extended': extended.value},
        mapper: (body, headers) {
          final Map<String, dynamic> json = body ?? <String, dynamic>{};
          return TraktCredits.fromJson(json);
        },
      );
    }

    /// Get rating distribution for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<TraktRating> getRatings(String id) async {
      return client.get(
        '/shows/$id/ratings',
        mapper: (body, headers) {
          final Map<String, dynamic> json = body ?? <String, dynamic>{};
          return TraktRating.fromJson(json);
        },
      );
    }

  /// Get related shows.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktShow>> getRelated(
    String id, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return getList(
      '/shows/$id/related',
      pagination: pagination,
      extended: extended,
      mapper: TraktShow.fromJson,
    );
  }

    /// Get show stats.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<TraktStats> getStats(String id) async {
      return client.get(
        '/shows/$id/stats',
        mapper: (body, headers) {
          final Map<String, dynamic> json = body ?? <String, dynamic>{};
          return TraktStats.fromJson(json);
        },
      );
    }

    /// Get all studios for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<TraktStudio>> getStudios(String id) async {
      return client.get(
        '/shows/$id/studios',
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .map(TraktStudio.fromJson)
              .toList();
        },
      );
    }

    /// Get all videos for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<TraktVideo>> getVideos(String id) async {
      return client.get(
        '/shows/$id/videos',
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .map(TraktVideo.fromJson)
              .toList();
        },
      );
    }

    /// Get users currently watching a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<List<TraktUser>> getWatching(String id,
        {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
      return client.get(
        '/shows/$id/watching',
        queryParams: {'extended': extended.value},
        mapper: (body, headers) {
          if (body == null) {
            return [];
          }
          if (body is! List) {
            return [];
          }
          return body
              .where((item) => item != null && item is Map<String, dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .map(TraktUser.fromJson)
              .toList();
        },
      );
    }

    /// Get collection progress for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<TraktShowProgress> getCollectionProgress(
      String id, {
      bool hidden = false,
      bool specials = false,
      bool countSpecials = false,
    }) async {
      return client.get(
        '/shows/$id/progress/collection',
        queryParams: {
          'hidden': hidden.toString(),
          'specials': specials.toString(),
          'count_specials': countSpecials.toString(),
        },
        mapper: (body, headers) {
          final Map<String, dynamic> json = body ?? <String, dynamic>{};
          return TraktShowProgress.fromJson(json);
        },
      );
    }

    /// Get watched progress for a show.
    ///
    /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
    Future<TraktShowProgress> getWatchedProgress(
      String id, {
      bool hidden = false,
      bool specials = false,
      bool countSpecials = false,
    }) async {
      return client.get(
        '/shows/$id/progress/watched',
        queryParams: {
          'hidden': hidden.toString(),
          'specials': specials.toString(),
          'count_specials': countSpecials.toString(),
        },
        mapper: (body, headers) {
          final Map<String, dynamic> json = body ?? <String, dynamic>{};
          return TraktShowProgress.fromJson(json);
        },
      );
    }

  /// Reset watched progress for a show.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> resetWatchedProgress(String id) async {
    await client.delete(
      '/shows/$id/progress/watched',
      mapper: (body, headers) => null,
    );
  }

  /// Get the next episode to air.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktEpisode?> getNextEpisode(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return client.get(
      '/shows/$id/next_episode',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => body == null
          ? null
          : TraktEpisode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get the last episode to air.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktEpisode?> getLastEpisode(String id,
      {TraktExtendedInfo extended = TraktExtendedInfo.min}) async {
    return client.get(
      '/shows/$id/last_episode',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) => body == null
          ? null
          : TraktEpisode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// [🔒 OAuth Required] Report a show for inappropriate content.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(String id,
      {required TraktReportReason reason, String? notes}) async {
    await client.post(
      '/shows/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// Refresh a show to get the latest metadata from TMDB.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> refresh(String id) async {
    await client.post(
      '/shows/$id/refresh',
      mapper: (body, headers) => null,
    );
  }
}
