import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_id_type.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_search_fields.dart';
import '../core/trakt_search_utils.dart';
import '../models/trakt_media_entity.dart';

class SearchApi {
  final TraktApiClient _client;

  SearchApi(this._client);

  /// Search by text query.
  ///
  /// If [escape] is true, special characters (+ - && || ! ( ) { } [ ] ^ " ~ * ? : / \)
  /// will be escaped with a backslash to be interpreted literally.
  Future<TraktListResponse<TraktMediaEntity>> textQuery(
    String query, {
    List<TraktMediaType>? types,
    List<TraktSearchField>? fields,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
    bool escape = false,
  }) async {
    final processedQuery = escape ? TraktSearchUtils.escape(query) : query;
    
    final typePath = types != null
        ? types.map((e) => e.singularValue).join(',')
        : 'movie,show,person,list';
    final queryParams = <String, String>{
      'query': processedQuery,
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
    };
    if (fields != null) queryParams['fields'] = fields.map((e) => e.value).join(',');
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return _client.get(
      '/search/$typePath',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktMediaEntity.fromJson(item as Map<String, dynamic>))
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
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktMediaEntity>> idLookup(
    String id, {
    required TraktIdType idType,
    TraktMediaType? type,
    int page = 1,
    int limit = 10,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended.value,
    };
    if (type != null) queryParams['type'] = type.singularValue;

    return _client.get(
      '/search/${idType.value}/$id',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktMediaEntity.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }
}
