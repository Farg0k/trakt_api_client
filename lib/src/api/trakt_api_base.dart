import '../core/trakt_api_client.dart';
import '../core/trakt_extended_info.dart';
import '../core/trakt_filters.dart';
import '../core/trakt_list_response.dart';
import '../core/trakt_pagination_params.dart';

/// Base class for all Trakt API modules.
abstract class TraktApiBase {
  /// Creates a new [TraktApiBase] instance.
  TraktApiBase(this.client);

  /// The internal client reference.
  final TraktApiClient client;

  /// Performs a GET request that returns a list with pagination.
  Future<TraktListResponse<T>> getList<T>(
    String path, {
    TraktPaginationParams? pagination,
    TraktExtendedInfo? extended,
    TraktFilters? filters,
    Map<String, String>? queryParams,
    bool authenticated = false,
    required T Function(Map<String, dynamic> json) mapper,
  }) async {
    final effectiveQueryParams = <String, String>{};
    if (extended != null) effectiveQueryParams['extended'] = extended.value;
    if (filters != null) effectiveQueryParams.addAll(filters.toQueryParams());
    if (queryParams != null) effectiveQueryParams.addAll(queryParams);

    return client.getList(
      path,
      queryParams:
          effectiveQueryParams.isEmpty ? null : effectiveQueryParams,
      pagination: pagination,
      authenticated: authenticated,
      mapper: mapper,
    );
  }
}


