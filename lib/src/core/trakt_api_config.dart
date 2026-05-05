class TraktApiClientConfig {
  final String clientId;
  final String? clientSecret;
  final String? accessToken;
  final String? refreshToken;
  final bool useStaging;
  final String? userAgent;
  final Map<String, String>? customHeaders;

  const TraktApiClientConfig({
    required this.clientId,
    this.clientSecret,
    this.accessToken,
    this.refreshToken,
    this.useStaging = false,
    this.userAgent,
    this.customHeaders,
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

    if (userAgent != null) {
      headers['User-Agent'] = userAgent!;
    }

    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders!);
    }

    return headers;
  }

  TraktApiClientConfig copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return TraktApiClientConfig(
      clientId: clientId,
      clientSecret: clientSecret,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      useStaging: useStaging,
      userAgent: userAgent,
      customHeaders: customHeaders,
    );
  }
}
