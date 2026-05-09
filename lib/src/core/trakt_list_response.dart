import 'trakt_pagination_params.dart';

/// Pagination info returned in headers.
class TraktPagination {
  /// Creates a new [TraktPagination] instance.
  TraktPagination({
    required this.itemCount,
    required this.pageCount,
    required this.limit,
    required this.currentPage,
  });

  /// Creates a [TraktPagination] from HTTP response headers.
  factory TraktPagination.fromHeaders(Map<String, String> headers) {
    return TraktPagination(
      itemCount: int.tryParse(headers['X-Pagination-Item-Count'] ?? '') ?? 0,
      pageCount: int.tryParse(headers['X-Pagination-Page-Count'] ?? '') ?? 0,
      limit: int.tryParse(headers['X-Pagination-Limit'] ?? '') ?? 0,
      currentPage: int.tryParse(headers['X-Pagination-Page'] ?? '') ?? 1,
    );
  }

  /// Total number of items across all pages.
  final int itemCount;

  /// Total number of pages.
  final int pageCount;

  /// Number of items per page.
  final int limit;

  /// The current page number.
  final int currentPage;

  @override
  String toString() {
    return 'TraktPagination(page: $currentPage, limit: $limit, pageCount: $pageCount, itemCount: $itemCount)';
  }
}

/// Generic response wrapper for lists.
class TraktListResponse<T> {
  /// Creates a new [TraktListResponse] instance.
  TraktListResponse({
    required this.data,
    this.pagination,
    this.requestParams,
  });

  /// The list of data items.
  final List<T> data;

  /// Pagination information (if available).
  final TraktPagination? pagination;

  /// The parameters used to make this request.
  final TraktPaginationParams? requestParams;

  /// Whether there is a next page available.
  bool get hasNextPage =>
      pagination != null && pagination!.currentPage < pagination!.pageCount;

  /// Whether there is a previous page available.
  bool get hasPrevPage => pagination != null && pagination!.currentPage > 1;

  /// Returns parameters for the next page, or null if not available.
  TraktPaginationParams? get nextPageParams {
    if (!hasNextPage) return null;
    return (requestParams ?? const TraktPaginationParams()).next();
  }

  /// Returns parameters for the previous page, or null if not available.
  TraktPaginationParams? get prevPageParams {
    if (!hasPrevPage) return null;
    return (requestParams ?? const TraktPaginationParams()).previous();
  }
}
