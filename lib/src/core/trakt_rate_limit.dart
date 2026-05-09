class TraktRateLimit {
  const TraktRateLimit({
    this.limit,
    this.remaining,
    this.reset,
    this.retryAfter,
  });

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
  final int? limit;
  final int? remaining;
  final DateTime? reset;
  final Duration? retryAfter;

  @override
  String toString() {
    return 'TraktRateLimit(limit: $limit, remaining: $remaining, reset: $reset, retryAfter: $retryAfter)';
  }
}
