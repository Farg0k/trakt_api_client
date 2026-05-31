/// Encapsulates pagination parameters for Trakt API requests.
class TraktPaginationParams {
  /// Creates a new [TraktPaginationParams] instance.
  const TraktPaginationParams({
    this.page = 1,
    this.limit = 10,
  });

  /// The page number to request.
  final int page;

  /// Number of items per page.
  final int limit;

  /// Converts the parameters to a map for use in query strings.
  Map<String, String> toQueryParams() {
    return {
      'page': page.toString(),
      'limit': limit.toString(),
    };
  }

  /// Creates a copy of these parameters with the next page number.
  TraktPaginationParams next() => TraktPaginationParams(page: page + 1, limit: limit);

  /// Creates a copy of these parameters with the previous page number.
  TraktPaginationParams? previous() =>
      page > 1 ? TraktPaginationParams(page: page - 1, limit: limit) : null;

  @override
  String toString() {
    return '''TraktPaginationParams{
      page: $page, 
      limit: $limit
    }''';
  }
}
