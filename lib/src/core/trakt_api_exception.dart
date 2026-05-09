import '../core/trakt_rate_limit.dart';

/// Custom exception thrown when a Trakt API request fails.
class TraktApiException implements Exception {

  /// Creates a new [TraktApiException] instance.
  const TraktApiException(
    this.message, {
    this.statusCode,
    this.responseBody,
    this.rateLimit,
  });
  /// The error message.
  final String message;
  /// The HTTP status code (if available).
  final int? statusCode;
  /// The raw response body from the server.
  final String? responseBody;
  /// Rate limit information at the time of the error.
  final TraktRateLimit? rateLimit;

  @override
  String toString() {
    final buffer = StringBuffer('TraktApiException: $message');
    if (statusCode != null) {
      buffer.write(' (Status Code: $statusCode)');
    }
    if (rateLimit != null) {
      buffer.write('\nRate Limit: $rateLimit');
    }
    if (responseBody != null && responseBody!.isNotEmpty) {
      buffer.write('\nResponse Body: $responseBody');
    }
    return buffer.toString();
  }
}
