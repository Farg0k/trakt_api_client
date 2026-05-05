import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../models/trakt_show.dart';

class ShowsApi {
  final TraktApiClient _client;

  ShowsApi(this._client);

  Future<TraktListResponse<TraktShow>> getTrending({
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended,
      if (filters != null) ...filters.toQueryParams(),
    };

    return _client.get(
      '/shows/trending',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) =>
                TraktShow.fromJson(item['show'] as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  Future<TraktListResponse<TraktShow>> getPopular({
    int page = 1,
    int limit = 10,
    String extended = TraktExtendedInfo.metadata,
    TraktFilters? filters,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'limit': limit.toString(),
      'extended': extended,
      if (filters != null) ...filters.toQueryParams(),
    };

    return _client.get(
      '/shows/popular',
      queryParams: queryParams,
      mapper: (body, headers) {
        final data = (body as List)
            .map((item) => TraktShow.fromJson(item as Map<String, dynamic>))
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
        );
      },
    );
  }

  Future<TraktShow> getDetails(
    String id, {
    String extended = TraktExtendedInfo.full,
  }) async {
    return _client.get(
      '/shows/$id',
      queryParams: {'extended': extended},
      mapper: (body, headers) =>
          TraktShow.fromJson(body as Map<String, dynamic>),
    );
  }
}
