import '../core/trakt_api_client.dart';
import '../models/trakt_auth_models.dart';

class AuthenticationApi {
  final TraktApiClient _client;

  AuthenticationApi(this._client);

  /// Generate new codes to start the device authentication flow.
  Future<TraktDeviceCode> generateDeviceCode() async {
    return _client.post(
      '/oauth/device/code',
      body: {'client_id': _client.config.clientId},
      mapper: (body, headers) =>
          TraktDeviceCode.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Poll for the access token after the user has authorized the app.
  Future<TraktOAuthToken> pollForDeviceToken(String deviceCode) async {
    return _client.post(
      '/oauth/device/token',
      body: {
        'code': deviceCode,
        'client_id': _client.config.clientId,
        'client_secret': _client.config.clientSecret,
      },
      mapper: (body, headers) =>
          TraktOAuthToken.fromJson(body as Map<String, dynamic>),
    );
  }

  /// Exchange an authorization code (or PIN) for an access token.
  Future<TraktOAuthToken> getToken(String code, {String redirectUri = 'urn:ietf:wg:oauth:2.0:oob'}) async {
    return _client.post(
      '/oauth/token',
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
  }

  /// Exchange a refresh token for a new access token.
  Future<TraktOAuthToken> refreshToken(String refreshToken) async {
    return _client.post(
      '/oauth/token',
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
  }

  /// Revoke an access token.
  Future<void> revokeToken(String accessToken) async {
    await _client.post(
      '/oauth/revoke',
      body: {
        'token': accessToken,
        'client_id': _client.config.clientId,
        'client_secret': _client.config.clientSecret,
      },
      mapper: (body, headers) => null,
    );
  }
}
