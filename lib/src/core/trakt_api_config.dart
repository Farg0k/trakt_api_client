/// Configuration for the [TraktApiClient].
class TraktApiClientConfig {
  /// Creates a new Trakt API configuration.
  TraktApiClientConfig({
    required this.clientId,
    this.clientSecret,
    this.accessToken,
    this.refreshToken,
    this.useStaging = false,
    this.userAgent,
    this.customHeaders,
  });

  /// The client ID (API Key) from your Trakt API dashboard.
  final String clientId;

  /// The client secret from your Trakt API dashboard.
  final String? clientSecret;

  /// The OAuth access token for authenticated requests.
  final String? accessToken;

  /// The OAuth refresh token used to acquire new access tokens.
  final String? refreshToken;

  /// Whether to use the Trakt API staging environment.
  final bool useStaging;

  /// The User-Agent string to identify your application.
  final String? userAgent;

  /// Any custom headers to include in every request.
  final Map<String, String>? customHeaders;

  /// Returns the base URL for the Trakt API.
  String get baseUrl =>
      useStaging ? 'https://api-staging.trakt.tv' : 'https://api.trakt.tv';

  /// Returns the base URL for Trakt authentication.
  String get authBaseUrl =>
      useStaging ? 'https://api-staging.trakt.tv' : 'https://auth.trakt.tv';

  /// Returns the headers to be included in every request.
  Map<String, String> getHeaders({bool authenticated = true}) {
    final headers = {
      'Content-Type': 'application/json',
      'trakt-api-version': '2',
      'trakt-api-key': clientId,
    };

    if (userAgent != null) {
      headers['User-Agent'] = userAgent!;
    }

    if (authenticated && accessToken != null && accessToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders!);
    }

    return headers;
  }

  /// Compatibility getter for existing code.
  Map<String, String> get headers => getHeaders();

  /// Creates a copy of this configuration with the given fields replaced.
  TraktApiClientConfig copyWith({String? accessToken, String? refreshToken}) {
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
