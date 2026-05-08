class TraktSharing {
  final bool? twitter;
  final bool? mastodon;
  final bool? tumblr;

  const TraktSharing({
    this.twitter,
    this.mastodon,
    this.tumblr,
  });

  Map<String, dynamic> toJson() {
    return {
      if (twitter != null) 'twitter': twitter,
      if (mastodon != null) 'mastodon': mastodon,
      if (tumblr != null) 'tumblr': tumblr,
    };
  }

  factory TraktSharing.fromJson(Map<String, dynamic> json) {
    return TraktSharing(
      twitter: json['twitter'] as bool?,
      mastodon: json['mastodon'] as bool?,
      tumblr: json['tumblr'] as bool?,
    );
  }
}
