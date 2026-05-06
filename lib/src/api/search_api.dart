import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_search_result.dart';

class SearchApi {
  final TraktApiClient _client;

  SearchApi(this._client);

  /// Search by text query.
  ///
  /// [types] can be a single type or a list of types: movie, show, episode, person, list.
  /// [fields] can be used to limit which fields are searched.
  Future<TraktListResponse<TraktSearchResult>> textQuery(
    String query, {
    List<String>? types,
    List<String>? fields,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    final typePath = types != null ? types.join(',') : 'movie,show,person,list';
    final queryParams = <String, String>{
      'query': query,
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended,
    };
    if (fields != null) queryParams['fields'] = fields.join(',');
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/search/$typePath',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktSearchResult.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  /// Lookup items by their ID.
  ///
  /// [idType] must be one of: trakt, imdb, tmdb, tvdb.
  /// [type] limits the results to a specific media type.
  Future<TraktListResponse<TraktSearchResult>> idLookup(
    String id, {
    required String idType,
    String? type,
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended,
    };
    if (type != null) queryParams['type'] = type;

    return _client.get(
      '/search/$idType/$id',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktSearchResult.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }
}
