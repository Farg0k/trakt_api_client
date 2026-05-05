class TraktPagination {
  final int itemCount;
  final int pageCount;
  final int limit;
  final int currentPage;

  const TraktPagination({
    required this.itemCount,
    required this.pageCount,
    required this.limit,
    required this.currentPage,
  });

  factory TraktPagination.fromHeaders(Map<String, String> headers) {
    return TraktPagination(
      itemCount: int.tryParse(headers['X-Pagination-Item-Count'] ?? '') ?? 0,
      pageCount: int.tryParse(headers['X-Pagination-Page-Count'] ?? '') ?? 0,
      limit: int.tryParse(headers['X-Pagination-Limit'] ?? '') ?? 0,
      currentPage: int.tryParse(headers['X-Pagination-Page'] ?? '') ?? 1,
    );
  }

  @override
  String toString() {
    return 'TraktPagination(page: $currentPage, limit: $limit, pageCount: $pageCount, itemCount: $itemCount)';
  }
}

class TraktListResponse<T> {
  final List<T> data;
  final TraktPagination? pagination;

  const TraktListResponse({
    required this.data,
    this.pagination,
  });
}
