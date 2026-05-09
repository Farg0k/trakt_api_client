/// Rate limit information returned by Trakt.
class TraktRateLimit {
  /// Creates a new [TraktRateLimit] instance.
  const TraktRateLimit({
    this.limit,
    this.remaining,
    this.reset,
    this.retryAfter,
  });

  /// Creates a [TraktRateLimit] from HTTP response headers.
  factory TraktRateLimit.fromHeaders(Map<String, String> headers) {
    final limit = int.tryParse(headers['X-Ratelimit-Limit'] ?? '');
    final remaining = int.tryParse(headers['X-Ratelimit-Remaining'] ?? '');
    final resetUnix = int.tryParse(headers['X-Ratelimit-Reset'] ?? '');
    final retryAfterSeconds = int.tryParse(headers['Retry-After'] ?? '');

    return TraktRateLimit(
      limit: limit,
      remaining: remaining,
      reset: resetUnix != null
          ? DateTime.fromMillisecondsSinceEpoch(resetUnix * 1000)
          : null,
      retryAfter: retryAfterSeconds != null
          ? Duration(seconds: retryAfterSeconds)
          : null,
    );
  }

  /// Total number of requests allowed per period.
  final int? limit;

  /// Number of requests remaining in the current period.
  final int? remaining;

  /// When the current period resets.
  final DateTime? reset;

  /// How long to wait before retrying (if rate limited).
  final Duration? retryAfter;

  @override
  String toString() {
    return 'TraktRateLimit(limit: $limit, remaining: $remaining, reset: $reset, retryAfter: $retryAfter)';
  }
}
