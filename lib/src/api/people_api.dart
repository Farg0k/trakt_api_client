import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_report_reason.dart';
import '../core/trakt_sort_types.dart';
import '../models/trakt_list.dart';
import '../models/trakt_person.dart';
import '../models/trakt_person_models.dart';
import '../models/trakt_generic_models.dart';
import '../core/trakt_date_utils.dart';

class PeopleApi {
  PeopleApi(this._client);
  final TraktApiClient _client;

  /// Get detailed person information.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktPerson> getSummary(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/people/$id',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktPerson.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get movie credits for a person.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktPersonMovieCredits> getMovies(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/people/$id/movies',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktPersonMovieCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get show credits for a person.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktPersonShowCredits> getShows(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return _client.get(
      '/people/$id/shows',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktPersonShowCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all lists that contain this person.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktList>> getLists(
    String id, {
    TraktListType type = TraktListType.personal,
    TraktListSort sort = TraktListSort.popular,
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/people/$id/lists/${type.value}/${sort.value}',
      queryParams: {'page': page.toString(), 'limit': limit.toString()},
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

  /// Get recently updated people.
  Future<TraktListResponse<TraktUpdate<TraktPerson>>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/people/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map(
              (item) => TraktUpdate<TraktPerson>.fromJson(
                item as Map<String, dynamic>,
                TraktPerson.fromJson,
                'person',
              ),
            )
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently updated person IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/people/updates/id/$dateStr',
      queryParams: {'page': page.toString(), 'limit': limit.toString()},
      mapper: (body, headers) {
        final data = (body as List).map((item) => item as int).toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Get recently deleted people.
  Future<TraktListResponse<TraktDeleted<TraktPerson>>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return _client.get(
      '/people/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended.value,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map(
              (item) => TraktDeleted<TraktPerson>.fromJson(
                item as Map<String, dynamic>,
                TraktPerson.fromJson,
                'person',
              ),
            )
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// [🔒 OAuth Required] Report a person for inappropriate content.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<void> report(
    String id, {
    required TraktReportReason reason,
    String? notes,
  }) async {
    await _client.post(
      '/people/$id/report',
      body: {'reason': reason.value, 'notes': notes}
        ..removeWhere((key, value) => value == null),
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }

  /// [🔒 OAuth Required] Refresh a person to get the latest metadata from TMDB.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  ///
  /// Note: This is a VIP only method.
  Future<void> refresh(String id) async {
    await _client.post(
      '/people/$id/refresh',
      authenticated: true,
      mapper: (body, headers) => null,
    );
  }
}
