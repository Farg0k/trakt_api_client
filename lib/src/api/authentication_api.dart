import '../core/trakt_api_client.dart';
import '../models/trakt_auth_models.dart';

/// Access to authentication endpoints.
class AuthenticationApi {

  /// Creates a new [AuthenticationApi] instance.
  AuthenticationApi(this._client);
  /// Internal client reference.
  final TraktApiClient _client;

  /// Generate new codes to start the device authentication flow.
  Future<TraktDeviceCode> generateDeviceCode() async {
    return _client.post(
      '/oauth/device/code',
      baseUrlOverride: _client.config.authBaseUrl,
      body: {'client_id': _client.config.clientId},
      mapper: (body, headers) =>
          TraktDeviceCode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Poll for the access token after the user has authorized the app.
  ///
  /// Automatically updates the parent [TraktApiClient] config with the new token.
  Future<TraktOAuthToken> pollForDeviceToken(String deviceCode) async {
    final token = await _client.post(
      '/oauth/device/token',
      baseUrlOverride: _client.config.authBaseUrl,
      body: {
        'code': deviceCode,
        'client_id': _client.config.clientId,
        'client_secret': _client.config.clientSecret,
      },
      mapper: (body, headers) =>
          TraktOAuthToken.fromJson(body as Map<String, dynamic>),
    );

    _updateClientConfig(token);
    return token;
  }

  /// Exchange an authorization code (or PIN) for an access token.
  ///
  /// Automatically updates the parent [TraktApiClient] config with the new token.
  Future<TraktOAuthToken> getToken(String code,
      {String redirectUri = 'urn:ietf:wg:oauth:2.0:oob'}) async {
    final token = await _client.post(
      '/oauth/token',
      baseUrlOverride: _client.config.authBaseUrl,
      body: {
        'code': code,
        'client_id': _client.config.clientId,
        'client_secret': _client.config.clientSecret,
        'redirect_uri': redirectUri,
        'grant_type': 'authorization_code',
      },
      mapper: (body, headers) =>
          TraktOAuthToken.fromJson(body as Map<String, dynamic>),
    );

    _updateClientConfig(token);
    return token;
  }

  /// Exchange a refresh token for a new access token.
  ///
  /// Automatically updates the parent [TraktApiClient] config with the new token.
  Future<TraktOAuthToken> refreshToken(String refreshToken) async {
    final token = await _client.post(
      '/oauth/token',
      baseUrlOverride: _client.config.authBaseUrl,
      body: {
        'refresh_token': refreshToken,
        'client_id': _client.config.clientId,
        'client_secret': _client.config.clientSecret,
        'grant_type': 'refresh_token',
        'redirect_uri': 'urn:ietf:wg:oauth:2.0:oob',
      },
      mapper: (body, headers) =>
          TraktOAuthToken.fromJson(body as Map<String, dynamic>),
    );

    _updateClientConfig(token);
    return token;
  }

  /// Revoke an access token and clear it from the client config.
  Future<void> revokeToken(String accessToken) async {
    await _client.post(
      '/oauth/revoke',
      baseUrlOverride: _client.config.authBaseUrl,
      body: {
        'token': accessToken,
        'client_id': _client.config.clientId,
        'client_secret': _client.config.clientSecret,
      },
      mapper: (body, headers) => null,
    );

    if (_client.config.accessToken == accessToken) {
      _client.config =
          _client.config.copyWith(accessToken: '', refreshToken: '');
    }
  }

  void _updateClientConfig(TraktOAuthToken token) {
    _client.config = _client.config.copyWith(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    );
    _client.onTokenRefreshed?.call(token);
  }
}