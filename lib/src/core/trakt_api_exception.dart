class TraktApiException implements Exception {
  final String message;
  final int? statusCode;

  TraktApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    if (statusCode != null) {
      return 'TraktApiException: $message (Status Code: $statusCode)';
    }
    return 'TraktApiException: $message';
  }
}
