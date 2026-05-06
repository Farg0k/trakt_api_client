import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_list_type.dart';
import '../core/trakt_report_reason.dart';
import '../models/trakt_list.dart';
import '../models/trakt_person.dart';
import '../models/trakt_person_models.dart';

class PeopleApi {
  final TraktApiClient _client;

  PeopleApi(this._client);

  /// Get detailed person information.
  Future<TraktPerson> getSummary(
    String id, {
    String extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/people/$id',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktPerson.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get movie credits for a person.
  Future<TraktPersonMovieCredits> getMovies(
    String id, {
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/people/$id/movies',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktPersonMovieCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get show credits for a person.
  Future<TraktPersonShowCredits> getShows(
    String id, {
    String extended = TraktExtendedInfo.metadata,
  }) async {
    return _client.get(
      '/people/$id/shows',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktPersonShowCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all lists that contain this person.
  Future<TraktListResponse<TraktList>> getLists(
    String id, {
    TraktListType type = TraktListType.personal,
    String sort = 'popular',
    int page = 1,
    int limit = 10,
  }) async {
    return _client.get(
      '/people/$id/lists/${type.value}/$sort',
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

  /// Get recently updated people.
  Future<TraktListResponse<TraktPersonUpdate>> getUpdates(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
    return _client.get(
      '/people/updates/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktPersonUpdate.fromJson(item as Map<String, dynamic>))
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
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
    return _client.get(
      '/people/updates/id/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
      },
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
  Future<TraktListResponse<TraktDeletedPerson>> getDeleted(
    DateTime startDate, {
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final dateStr = startDate.toUtc().toIso8601String().split('T')[0];
    return _client.get(
      '/people/updates/deleted/$dateStr',
      queryParams: {
        'page': page.toString(),
        'limit': limit.toString(),
        'extended': extended,
      },
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktDeletedPerson.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Report a person for inappropriate content.
  Future<void> report(String id,
      {required TraktReportReason reason, String? notes}) async {
    await _client.post(
      '/people/$id/report',
      body: {
        'reason': reason.value,
        'notes': notes,
      }..removeWhere((key, value) => value == null),
      mapper: (body, headers) => null,
    );
  }

  /// Refresh a person to get the latest metadata from TMDB.
  ///
  /// Note: This is a VIP only method.
  Future<void> refresh(String id) async {
    await _client.post(
      '/people/$id/refresh',
      mapper: (body, headers) => null,
    );
  }
}
