/// OAuth connection details for a single service.
class TraktServiceConnection {
  /// Creates a [TraktServiceConnection] from a JSON map.
  factory TraktServiceConnection.fromJson(Map<String, dynamic> json) {
    return TraktServiceConnection(
      connected: json['connected'] as bool? ?? false,
      token: json['token'] as String?,
      secret: json['secret'] as String?,
      authorizedAt: json['authorized_at'] != null
          ? DateTime.tryParse(json['authorized_at'] as String)
          : null,
      username: json['username'] as String?,
    );
  }

  /// Creates a new [TraktServiceConnection] instance.
  const TraktServiceConnection({
    required this.connected,
    this.token,
    this.secret,
    this.authorizedAt,
    this.username,
  });

  /// Whether the service is connected.
  final bool connected;

  /// OAuth token.
  final String? token;

  /// OAuth secret.
  final String? secret;

  /// When authorization was granted.
  final DateTime? authorizedAt;

  /// Service username (if different from Trakt username).
  final String? username;

  /// Converts to JSON.
  Map<String, dynamic> toJson() {
    return {
      'connected': connected,
      if (token != null) 'token': token,
      if (secret != null) 'secret': secret,
      if (authorizedAt != null)
        'authorized_at': authorizedAt!.toIso8601String(),
      if (username != null) 'username': username,
    };
  }

  @override
  String toString() {
    return '''TraktServiceConnection{
      connected: $connected, 
      token: $token, 
      secret: $secret, 
      authorizedAt: $authorizedAt, 
      username: $username
    }''';
  }
}

/// Collection of all social service connections.
class TraktUserConnections {
  /// Creates a [TraktUserConnections] from a JSON map.
  factory TraktUserConnections.fromJson(Map<String, dynamic> json) {
    return TraktUserConnections(
      twitter: json['twitter'] != null
          ? TraktServiceConnection.fromJson(
              json['twitter'] as Map<String, dynamic>,
            )
          : null,
      facebook: json['facebook'] != null
          ? TraktServiceConnection.fromJson(
              json['facebook'] as Map<String, dynamic>,
            )
          : null,
      instagram: json['instagram'] != null
          ? TraktServiceConnection.fromJson(
              json['instagram'] as Map<String, dynamic>,
            )
          : null,
      tumblr: json['tumblr'] != null
          ? TraktServiceConnection.fromJson(
              json['tumblr'] as Map<String, dynamic>,
            )
          : null,
      slack: json['slack'] != null
          ? TraktServiceConnection.fromJson(
              json['slack'] as Map<String, dynamic>,
            )
          : null,
      webhook: json['webhook'] != null
          ? TraktServiceConnection.fromJson(
              json['webhook'] as Map<String, dynamic>,
            )
          : null,
      twitterRead: json['twitter_read'] != null
          ? TraktServiceConnection.fromJson(
              json['twitter_read'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// Creates a new [TraktUserConnections] instance.
  const TraktUserConnections({
    this.twitter,
    this.facebook,
    this.instagram,
    this.tumblr,
    this.slack,
    this.webhook,
    this.twitterRead,
  });

  /// Twitter connection.
  final TraktServiceConnection? twitter;

  /// Facebook connection.
  final TraktServiceConnection? facebook;

  /// Instagram connection.
  final TraktServiceConnection? instagram;

  /// Tumblr connection.
  final TraktServiceConnection? tumblr;

  /// Slack connection.
  final TraktServiceConnection? slack;

  /// Webhook connection.
  final TraktServiceConnection? webhook;

  /// Twitter read-only connection.
  final TraktServiceConnection? twitterRead;

  /// Converts to JSON.
  Map<String, dynamic> toJson() {
    return {
      if (twitter != null) 'twitter': twitter!.toJson(),
      if (facebook != null) 'facebook': facebook!.toJson(),
      if (instagram != null) 'instagram': instagram!.toJson(),
      if (tumblr != null) 'tumblr': tumblr!.toJson(),
      if (slack != null) 'slack': slack!.toJson(),
      if (webhook != null) 'webhook': webhook!.toJson(),
      if (twitterRead != null) 'twitter_read': twitterRead!.toJson(),
    };
  }

  @override
  String toString() {
    return '''TraktUserConnections{
      twitter: $twitter, 
      facebook: $facebook, 
      instagram: $instagram, 
      tumblr: $tumblr, 
      slack: $slack, 
      webhook: $webhook, 
      twitterRead: $twitterRead
    }''';
  }
}
