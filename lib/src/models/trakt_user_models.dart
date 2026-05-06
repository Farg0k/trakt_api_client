import 'trakt_user.dart';

class TraktUserSocialIds {
  final String? twitter;
  final String? facebook;
  final String? instagram;
  final String? tumblr;

  const TraktUserSocialIds({
    this.twitter,
    this.facebook,
    this.instagram,
    this.tumblr,
  });

  factory TraktUserSocialIds.fromJson(Map<String, dynamic> json) {
    return TraktUserSocialIds(
      twitter: json['twitter'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      tumblr: json['tumblr'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'twitter': twitter,
      'facebook': facebook,
      'instagram': instagram,
      'tumblr': tumblr,
    };
  }
}

class TraktUserSettings {
  final TraktUser user;
  final TraktAccountSettings account;
  final TraktConnectionsSettings connections;
  final TraktSharingTextSettings sharingText;

  const TraktUserSettings({
    required this.user,
    required this.account,
    required this.connections,
    required this.sharingText,
  });

  factory TraktUserSettings.fromJson(Map<String, dynamic> json) {
    return TraktUserSettings(
      user: TraktUser.fromJson(json['user'] as Map<String, dynamic>),
      account: TraktAccountSettings.fromJson(json['account'] as Map<String, dynamic>),
      connections: TraktConnectionsSettings.fromJson(json['connections'] as Map<String, dynamic>),
      sharingText: TraktSharingTextSettings.fromJson(json['sharing_text'] as Map<String, dynamic>),
    );
  }
}

class TraktAccountSettings {
  final String timezone;
  final bool time24hr;
  final String coverImage;
  final String token;

  const TraktAccountSettings({
    required this.timezone,
    required this.time24hr,
    required this.coverImage,
    required this.token,
  });

  factory TraktAccountSettings.fromJson(Map<String, dynamic> json) {
    return TraktAccountSettings(
      timezone: json['timezone'] as String,
      time24hr: json['time_24hr'] as bool,
      coverImage: json['cover_image'] as String,
      token: json['token'] as String,
    );
  }
}

class TraktConnectionsSettings {
  final bool facebook;
  final bool twitter;
  final bool google;
  final bool tumblr;
  final bool slack;

  const TraktConnectionsSettings({
    required this.facebook,
    required this.twitter,
    required this.google,
    required this.tumblr,
    required this.slack,
  });

  factory TraktConnectionsSettings.fromJson(Map<String, dynamic> json) {
    return TraktConnectionsSettings(
      facebook: json['facebook'] as bool,
      twitter: json['twitter'] as bool,
      google: json['google'] as bool,
      tumblr: json['tumblr'] as bool,
      slack: json['slack'] as bool,
    );
  }
}

class TraktSharingTextSettings {
  final String watching;
  final String watched;

  const TraktSharingTextSettings({
    required this.watching,
    required this.watched,
  });

  factory TraktSharingTextSettings.fromJson(Map<String, dynamic> json) {
    return TraktSharingTextSettings(
      watching: json['watching'] as String,
      watched: json['watched'] as String,
    );
  }
}

class TraktUserStats {
  final TraktMovieStatsSummary movies;
  final TraktShowStatsSummary shows;
  final TraktSeasonStatsSummary seasons;
  final TraktEpisodeStatsSummary episodes;
  final TraktNetworkStatsSummary networks;
  final TraktRatingStatsSummary ratings;

  const TraktUserStats({
    required this.movies,
    required this.shows,
    required this.seasons,
    required this.episodes,
    required this.networks,
    required this.ratings,
  });

  factory TraktUserStats.fromJson(Map<String, dynamic> json) {
    return TraktUserStats(
      movies: TraktMovieStatsSummary.fromJson(json['movies'] as Map<String, dynamic>),
      shows: TraktShowStatsSummary.fromJson(json['shows'] as Map<String, dynamic>),
      seasons: TraktSeasonStatsSummary.fromJson(json['seasons'] as Map<String, dynamic>),
      episodes: TraktEpisodeStatsSummary.fromJson(json['episodes'] as Map<String, dynamic>),
      networks: TraktNetworkStatsSummary.fromJson(json['networks'] as Map<String, dynamic>),
      ratings: TraktRatingStatsSummary.fromJson(json['ratings'] as Map<String, dynamic>),
    );
  }
}

class TraktMovieStatsSummary {
  final int plays;
  final int watched;
  final int minutes;
  final int collectors;
  final int ratings;
  final int comments;

  const TraktMovieStatsSummary({
    required this.plays,
    required this.watched,
    required this.minutes,
    required this.collectors,
    required this.ratings,
    required this.comments,
  });

  factory TraktMovieStatsSummary.fromJson(Map<String, dynamic> json) {
    return TraktMovieStatsSummary(
      plays: json['plays'] as int,
      watched: json['watched'] as int,
      minutes: json['minutes'] as int,
      collectors: json['collectors'] as int,
      ratings: json['ratings'] as int,
      comments: json['comments'] as int,
    );
  }
}

// Simplified summaries for brevity but maintaining all data
class TraktShowStatsSummary {
  final int watched;
  final int collectors;
  final int ratings;
  final int comments;

  const TraktShowStatsSummary({
    required this.watched,
    required this.collectors,
    required this.ratings,
    required this.comments,
  });

  factory TraktShowStatsSummary.fromJson(Map<String, dynamic> json) {
    return TraktShowStatsSummary(
      watched: json['watched'] as int,
      collectors: json['collectors'] as int,
      ratings: json['ratings'] as int,
      comments: json['comments'] as int,
    );
  }
}

class TraktSeasonStatsSummary {
  final int ratings;
  final int comments;

  const TraktSeasonStatsSummary({required this.ratings, required this.comments});

  factory TraktSeasonStatsSummary.fromJson(Map<String, dynamic> json) {
    return TraktSeasonStatsSummary(
      ratings: json['ratings'] as int,
      comments: json['comments'] as int,
    );
  }
}

class TraktEpisodeStatsSummary {
  final int plays;
  final int watched;
  final int minutes;
  final int ratings;
  final int comments;

  const TraktEpisodeStatsSummary({
    required this.plays,
    required this.watched,
    required this.minutes,
    required this.ratings,
    required this.comments,
  });

  factory TraktEpisodeStatsSummary.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeStatsSummary(
      plays: json['plays'] as int,
      watched: json['watched'] as int,
      minutes: json['minutes'] as int,
      ratings: json['ratings'] as int,
      comments: json['comments'] as int,
    );
  }
}

class TraktNetworkStatsSummary {
  final int count;

  const TraktNetworkStatsSummary({required this.count});

  factory TraktNetworkStatsSummary.fromJson(Map<String, dynamic> json) {
    return TraktNetworkStatsSummary(
      count: json['count'] as int,
    );
  }
}

class TraktRatingStatsSummary {
  final int total;
  final Map<String, int> distribution;

  const TraktRatingStatsSummary({required this.total, required this.distribution});

  factory TraktRatingStatsSummary.fromJson(Map<String, dynamic> json) {
    return TraktRatingStatsSummary(
      total: json['total'] as int,
      distribution: Map<String, int>.from(json['distribution'] as Map),
    );
  }
}

class TraktFollowRequest {
  final int id;
  final DateTime requestedAt;
  final TraktUser user;

  const TraktFollowRequest({
    required this.id,
    required this.requestedAt,
    required this.user,
  });

  factory TraktFollowRequest.fromJson(Map<String, dynamic> json) {
    return TraktFollowRequest(
      id: json['id'] as int,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      user: TraktUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

class TraktUserConnection {
  final DateTime followedAt;
  final TraktUser user;

  const TraktUserConnection({required this.followedAt, required this.user});

  factory TraktUserConnection.fromJson(Map<String, dynamic> json) {
    return TraktUserConnection(
      followedAt: DateTime.parse(json['followed_at'] as String),
      user: TraktUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}
