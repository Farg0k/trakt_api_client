class TraktApiClientConfig {
  final String clientId;
  final String? clientSecret;
  final String? accessToken;
  final bool useStaging;

  const TraktApiClientConfig({
    required this.clientId,
    this.clientSecret,
    this.accessToken,
    this.useStaging = false,
  });

  String get baseUrl => useStaging
      ? 'https://api-staging.trakt.tv'
      : 'https://api.trakt.tv';

  Map<String, String> get headers {
    final headers = {
      'Content-Type': 'application/json',
      'trakt-api-version': '2',
      'trakt-api-key': clientId,
    };

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    return headers;
  }
}
