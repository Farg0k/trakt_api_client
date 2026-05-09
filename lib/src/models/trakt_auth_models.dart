class TraktDeviceCode {
  const TraktDeviceCode({
    required this.deviceCode,
    required this.userCode,
    required this.verificationUrl,
    required this.expiresIn,
    required this.interval,
  });

  factory TraktDeviceCode.fromJson(Map<String, dynamic> json) {
    return TraktDeviceCode(
      deviceCode: json['device_code'] as String,
      userCode: json['user_code'] as String,
      verificationUrl: json['verification_url'] as String,
      expiresIn: json['expires_in'] as int,
      interval: json['interval'] as int,
    );
  }
  final String deviceCode;
  final String userCode;
  final String verificationUrl;
  final int expiresIn;
  final int interval;
}

class TraktOAuthToken {
  const TraktOAuthToken({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.scope,
    required this.createdAt,
  });

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
  final String accessToken;
  final String tokenType;
  final int expiresIn;
  final String refreshToken;
  final String scope;
  final int createdAt;

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
