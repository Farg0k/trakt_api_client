import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_id_type.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_media_type.dart';
import '../core/trakt_search_fields.dart';
import '../core/trakt_search_utils.dart';
import '../core/trakt_pagination_params.dart';
import '../models/trakt_media_entity.dart';
import 'trakt_api_base.dart';

/// Access to search endpoints.
class SearchApi extends TraktApiBase {
  /// Creates a new [SearchApi] instance.
  SearchApi(super.client);

  /// Search by text query.
  ///
  /// If [escape] is true, special characters (`+ - && || ! ( ) { } [ ] ^ " ~ * ? : / \`)
  /// will be escaped with a backslash to be interpreted literally.
  Future<TraktListResponse<TraktMediaEntity>> textQuery(
    String query, {
    List<TraktMediaType>? types,
    List<TraktSearchField>? fields,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
    TraktFilters? filters,
    bool escape = false,
  }) async {
    final processedQuery = escape ? TraktSearchUtils.escape(query) : query;

    final typePath = types != null
        ? types.map((e) => e.singularValue).join(',')
        : 'movie,show,person,list';
    final queryParams = <String, String>{'query': processedQuery};
    if (fields != null) {
      queryParams['fields'] = fields.map((e) => e.value).join(',');
    }

    return getList(
      '/search/$typePath',
      pagination: pagination,
      queryParams: queryParams,
      extended: extended,
      filters: filters,
      mapper: TraktMediaEntity.fromJson,
    );
  }

  /// Lookup items by their ID.
  ///
  /// [id] can be a Trakt ID, Trakt slug, or IMDB ID.
  Future<TraktListResponse<TraktMediaEntity>> idLookup(
    String id, {
    required TraktIdType idType,
    TraktMediaType? type,
    TraktPaginationParams? pagination,
    TraktExtendedInfo extended = TraktExtendedInfo.min,
  }) async {
    final queryParams = <String, String>{};
    if (type != null) queryParams['type'] = type.singularValue;

    return getList(
      '/search/${idType.value}/$id',
      pagination: pagination,
      queryParams: queryParams.isEmpty ? null : queryParams,
      extended: extended,
      mapper: TraktMediaEntity.fromJson,
    );
  }
}
