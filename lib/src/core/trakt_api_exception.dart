class TraktApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;

  TraktApiException(this.message, {this.statusCode, this.responseBody});

  @override
  String toString() {
    final buffer = StringBuffer('TraktApiException: $message');
    if (statusCode != null) {
      buffer.write(' (Status Code: $statusCode)');
    }
    if (responseBody != null && responseBody!.isNotEmpty) {
      buffer.write('\nResponse Body: $responseBody');
    }
    return buffer.toString();
  }
}
