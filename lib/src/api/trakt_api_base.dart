import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';

/// Base class for all Trakt API modules.
abstract class TraktApiBase {
  /// Creates a new [TraktApiBase] instance.
  TraktApiBase(this.client);

  /// The internal client reference.
  final TraktApiClient client;

  /// Performs a GET request that returns a list with pagination.
  Future<TraktListResponse<T>> getList<T>(
    String path, {
    int? page,
    int? limit,
    TraktExtendedInfo? extended,
    TraktFilters? filters,
    required T Function(Map<String, dynamic> json) mapper,
  }) async {
    final queryParams = <String, String>{};
    if (page != null) queryParams['page'] = page.toString();
    if (limit != null) queryParams['limit'] = limit.toString();
    if (extended != null) queryParams['extended'] = extended.value;
    if (filters != null) queryParams.addAll(filters.toQueryParams());

    return client.getList(
      path,
      queryParams: queryParams.isEmpty ? null : queryParams,
      mapper: mapper,
    );
  }
}
