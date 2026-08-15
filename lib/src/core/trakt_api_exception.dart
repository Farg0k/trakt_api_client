import 'dart:convert';
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

  /// Attempts to extract a detailed error message from the response body.
  String get detailedMessage {
    if (responseBody == null || responseBody!.isEmpty) return message;
    try {
      final body = jsonDecode(responseBody!);
      if (body is Map) {
        if (body.containsKey('error_description')) {
          return body['error_description'] as String;
        }
        if (body.containsKey('message')) {
          return body['message'] as String;
        }
      }
      return message;
    } catch (_) {
      return message;
    }
  }

  /// Returns true if this error indicates that the session is invalid or expired
  /// and cannot be refreshed (e.g., refresh token is also invalid).
  bool get isSessionExpired {
    if (statusCode == 400) {
      final msg = detailedMessage.toLowerCase();
      return msg.contains('session not found') ||
          msg.contains('invalid_grant') ||
          msg.contains('invalid refresh_token');
    }
    return statusCode == 401;
  }

  @override
  String toString() {
    final buffer = StringBuffer('TraktApiException: $detailedMessage');
    if (statusCode != null) {
      buffer.write(' (Status Code: $statusCode)');
    }
    if (rateLimit != null) {
      buffer.write('\nRate Limit: $rateLimit');
    }
    return buffer.toString();
  }
}
