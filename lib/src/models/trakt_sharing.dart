/// Represents social sharing settings.
class TraktSharing {
  /// Creates a new [TraktSharing] instance.
  const TraktSharing({this.twitter, this.mastodon, this.tumblr});

  /// Creates a [TraktSharing] from a JSON map.
  factory TraktSharing.fromJson(Map<String, dynamic> json) {
    return TraktSharing(
      twitter: json['twitter'] as bool?,
      mastodon: json['mastodon'] as bool?,
      tumblr: json['tumblr'] as bool?,
    );
  }

  /// Share to Twitter.
  final bool? twitter;

  /// Share to Mastodon.
  final bool? mastodon;

  /// Share to Tumblr.
  final bool? tumblr;

  /// Converts this sharing settings to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      if (twitter != null) 'twitter': twitter,
      if (mastodon != null) 'mastodon': mastodon,
      if (tumblr != null) 'tumblr': tumblr,
    };
  }

  @override
  String toString() {
    return '''TraktSharing{
      twitter: $twitter, 
      mastodon: $mastodon, 
      tumblr: $tumblr
    }''';
  }
}
