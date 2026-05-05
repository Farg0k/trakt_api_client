import 'trakt_rate_limit.dart';

class TraktApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;
  final TraktRateLimit? rateLimit;

  TraktApiException(
    this.message, {
    this.statusCode,
    this.responseBody,
    this.rateLimit,
  });

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
