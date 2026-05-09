import '../core/trakt_extended_info.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_media_models.dart';
import '../models/trakt_generic_models.dart';
import '../models/trakt_person.dart';
import '../models/trakt_person_models.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_api_base.dart';

/// Access to people endpoints.
class PeopleApi extends TraktApiBase {
  /// Creates a new [PeopleApi] instance.
  PeopleApi(super.client);

  /// Get detailed person information.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktPerson> getSummary(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/people/$id',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktPerson.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get movie credits for a person.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktPersonMovieCredits> getMovieCredits(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/people/$id/movies',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktPersonMovieCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get show credits for a person.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktPersonShowCredits> getShowCredits(
    String id, {
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    return client.get(
      '/people/$id/shows',
      queryParams: {'extended': extended.value},
      mapper: (body, headers) =>
          TraktPersonShowCredits.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Get all title aliases for a person.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<List<TraktMediaAlias>> getAliases(String id) async {
    return client.get(
      '/people/$id/aliases',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktMediaAlias.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Get recently updated people.
  Future<TraktListResponse<TraktMetadata<TraktPerson>>> getUpdates(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/people/updates/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktPerson.fromJson, 'person'),
    );
  }

  /// Get recently updated person IDs.
  Future<TraktListResponse<int>> getUpdatedIds(
    DateTime startDate, {
    TraktPaginationParams? pagination,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/people/updates/id/$dateStr',
      pagination: pagination,
      mapper: (json) => json as int,
    );
  }

  /// Get recently deleted people.
  Future<TraktListResponse<TraktMetadata<TraktPerson>>> getDeleted(
    DateTime startDate, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final dateStr = TraktDateUtils.formatPathDate(startDate);
    return getList(
      '/people/updates/deleted/$dateStr',
      pagination: pagination,
      extended: extended,
      mapper: (json) =>
          TraktMetadata.fromJson(json, TraktPerson.fromJson, 'person'),
    );
  }
}
