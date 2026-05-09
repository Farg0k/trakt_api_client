/// Represents a device code response from Trakt.
class TraktDeviceCode {

  /// Creates a new [TraktDeviceCode] instance.
  const TraktDeviceCode({
    required this.deviceCode,
    required this.userCode,
    required this.verificationUrl,
    required this.expiresIn,
    required this.interval,
  });

  /// Creates a [TraktDeviceCode] from a JSON map.
  factory TraktDeviceCode.fromJson(Map<String, dynamic> json) {
    return TraktDeviceCode(
      deviceCode: json['device_code'] as String,
      userCode: json['user_code'] as String,
      verificationUrl: json['verification_url'] as String,
      expiresIn: json['expires_in'] as int,
      interval: json['interval'] as int,
    );
  }
  /// The code used to poll for the access token.
  final String deviceCode;
  /// The code the user needs to enter on the Trakt website.
  final String userCode;
  /// The URL where the user should enter the [userCode].
  final String verificationUrl;
  /// Number of seconds until the codes expire.
  final int expiresIn;
  /// Number of seconds between polling requests.
  final int interval;
}

/// Represents an OAuth access token.
class TraktOAuthToken {

  /// Creates a new [TraktOAuthToken] instance.
  const TraktOAuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.createdAt,
  });

  /// Creates a [TraktOAuthToken] from a JSON map.
  factory TraktOAuthToken.fromJson(Map<String, dynamic> json) {
    return TraktOAuthToken(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
      refreshToken: json['refresh_token'] as String,
      scope: json['scope'] as String,
      createdAt: json['created_at'] as int,
    );
  }
  /// The access token string.
  final String accessToken;
  /// The type of token (e.g. Bearer).
  final String tokenType;
  /// Number of seconds until the token expires.
  final int expiresIn;
  /// The refresh token string.
  final String refreshToken;
  /// The scope of the token.
  final String scope;
  /// When the token was created (Unix timestamp).
  final int createdAt;

  /// Converts this token to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'refresh_token': refreshToken,
      'scope': scope,
      'created_at': createdAt,
    };
  }
}
