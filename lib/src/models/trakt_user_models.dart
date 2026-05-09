import 'trakt_user.dart';

/// Social IDs for a user.
class TraktUserSocialIds {

  /// Creates a [TraktUserSocialIds] from a JSON map.
  factory TraktUserSocialIds.fromJson(Map<String, dynamic> json) {
    return TraktUserSocialIds(
      twitter: json['twitter'] as String?,
      facebook: json['facebook'] as String?,
      instagram: json['instagram'] as String?,
      tumblr: json['tumblr'] as String?,
    );
  }
  /// Creates a new [TraktUserSocialIds] instance.
  const TraktUserSocialIds({
    this.twitter,
    this.facebook,
    this.instagram,
    this.tumblr,
  });

  /// Twitter username.
  final String? twitter;

  /// Facebook username.
  final String? facebook;

  /// Instagram username.
  final String? instagram;

  /// Tumblr username.
  final String? tumblr;
}

/// A follow request from another user.
class TraktFollowRequest {

  /// Creates a [TraktFollowRequest] from a JSON map.
  factory TraktFollowRequest.fromJson(Map<String, dynamic> json) {
    return TraktFollowRequest(
      id: json['id'] as int,
      requestedAt: DateTime.parse(json['requested_at'] as String),
      user: TraktUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
  /// Creates a new [TraktFollowRequest] instance.
  const TraktFollowRequest({
    required this.id,
    required this.requestedAt,
    required this.user,
  });

  /// Unique ID of the follow request.
  final int id;

  /// When the request was made.
  final DateTime requestedAt;

  /// The user who made the request.
  final TraktUser user;
}

/// A connection between two users (follower/friend).
class TraktUserConnection {

  /// Creates a [TraktUserConnection] from a JSON map.
  factory TraktUserConnection.fromJson(Map<String, dynamic> json) {
    return TraktUserConnection(
      followedAt: DateTime.parse(json['followed_at'] as String),
      user: TraktUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
  /// Creates a new [TraktUserConnection] instance.
  const TraktUserConnection({
    required this.followedAt,
    required this.user,
  });

  /// When the connection was established.
  final DateTime followedAt;

  /// The user object.
  final TraktUser user;
}

/// Comprehensive statistics for a user profile.
class TraktUserStats {

  /// Creates a [TraktUserStats] from a JSON map.
  factory TraktUserStats.fromJson(Map<String, dynamic> json) {
    return TraktUserStats(
      movies:
          TraktUserMovieStats.fromJson(json['movies'] as Map<String, dynamic>),
      shows: TraktUserShowStats.fromJson(json['shows'] as Map<String, dynamic>),
      episodes: TraktUserEpisodeStats.fromJson(
          json['episodes'] as Map<String, dynamic>),
      network: TraktUserNetworkStats.fromJson(
          json['network'] as Map<String, dynamic>),
      ratings: TraktUserRatingStats.fromJson(
          json['ratings'] as Map<String, dynamic>),
    );
  }
  /// Creates a new [TraktUserStats] instance.
  const TraktUserStats({
    required this.movies,
    required this.shows,
    required this.episodes,
    required this.network,
    required this.ratings,
  });

  /// Movie-related statistics.
  final TraktUserMovieStats movies;

  /// Show-related statistics.
  final TraktUserShowStats shows;

  /// Episode-related statistics.
  final TraktUserEpisodeStats episodes;

  /// Network-related statistics (friends, followers).
  final TraktUserNetworkStats network;

  /// Rating-related statistics.
  final TraktUserRatingStats ratings;
}

/// User movie statistics.
class TraktUserMovieStats {

  /// Creates a [TraktUserMovieStats] from a JSON map.
  factory TraktUserMovieStats.fromJson(Map<String, dynamic> json) {
    return TraktUserMovieStats(
      plays: json['plays'] as int? ?? 0,
      watched: json['watched'] as int? ?? 0,
      collected: json['collected'] as int? ?? 0,
      ratings: json['ratings'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
    );
  }
  /// Creates a new [TraktUserMovieStats] instance.
  const TraktUserMovieStats({
    required this.plays,
    required this.watched,
    required this.collected,
    required this.ratings,
    required this.comments,
  });

  /// Number of unique movies watched.
  final int plays;

  /// Total number of movies watched.
  final int watched;

  /// Number of movies collected.
  final int collected;

  /// Number of movies rated.
  final int ratings;

  /// Number of comments on movies.
  final int comments;
}

/// User show statistics.
class TraktUserShowStats {

  /// Creates a [TraktUserShowStats] from a JSON map.
  factory TraktUserShowStats.fromJson(Map<String, dynamic> json) {
    return TraktUserShowStats(
      watched: json['watched'] as int? ?? 0,
      collected: json['collected'] as int? ?? 0,
      ratings: json['ratings'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
    );
  }
  /// Creates a new [TraktUserShowStats] instance.
  const TraktUserShowStats({
    required this.watched,
    required this.collected,
    required this.ratings,
    required this.comments,
  });

  /// Number of unique shows watched.
  final int watched;

  /// Number of shows collected.
  final int collected;

  /// Number of shows rated.
  final int ratings;

  /// Number of comments on shows.
  final int comments;
}

/// User episode statistics.
class TraktUserEpisodeStats {

  /// Creates a [TraktUserEpisodeStats] from a JSON map.
  factory TraktUserEpisodeStats.fromJson(Map<String, dynamic> json) {
    return TraktUserEpisodeStats(
      plays: json['plays'] as int? ?? 0,
      watched: json['watched'] as int? ?? 0,
      collected: json['collected'] as int? ?? 0,
      ratings: json['ratings'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
    );
  }
  /// Creates a new [TraktUserEpisodeStats] instance.
  const TraktUserEpisodeStats({
    required this.plays,
    required this.watched,
    required this.collected,
    required this.ratings,
    required this.comments,
  });

  /// Number of unique episodes watched.
  final int plays;

  /// Total number of episodes watched.
  final int watched;

  /// Number of episodes collected.
  final int collected;

  /// Number of episodes rated.
  final int ratings;

  /// Number of comments on episodes.
  final int comments;
}

/// User network statistics (friends, followers).
class TraktUserNetworkStats {

  /// Creates a [TraktUserNetworkStats] from a JSON map.
  factory TraktUserNetworkStats.fromJson(Map<String, dynamic> json) {
    return TraktUserNetworkStats(
      friends: json['friends'] as int? ?? 0,
      followers: json['followers'] as int? ?? 0,
      following: json['following'] as int? ?? 0,
    );
  }
  /// Creates a new [TraktUserNetworkStats] instance.
  const TraktUserNetworkStats({
    required this.friends,
    required this.followers,
    required this.following,
  });

  /// Number of friends.
  final int friends;

  /// Number of followers.
  final int followers;

  /// Number of users following.
  final int following;
}

/// User rating statistics.
class TraktUserRatingStats {

  /// Creates a [TraktUserRatingStats] from a JSON map.
  factory TraktUserRatingStats.fromJson(Map<String, dynamic> json) {
    return TraktUserRatingStats(
      total: json['total'] as int? ?? 0,
      distribution: Map<String, int>.from(json['distribution'] as Map? ?? {}),
    );
  }
  /// Creates a new [TraktUserRatingStats] instance.
  const TraktUserRatingStats({
    required this.total,
    required this.distribution,
  });

  /// Total number of ratings.
  final int total;

  /// Rating distribution (1-10).
  final Map<String, int> distribution;
}

/// User account settings.
class TraktUserSettings {

  /// Creates a [TraktUserSettings] from a JSON map.
  factory TraktUserSettings.fromJson(Map<String, dynamic> json) {
    return TraktUserSettings(
      user: TraktUser.fromJson(json['user'] as Map<String, dynamic>),
      account: json['account'] as Map<String, dynamic>? ?? {},
      connections: json['connections'] as Map<String, dynamic>? ?? {},
      sharingText: json['sharing_text'] as Map<String, dynamic>? ?? {},
    );
  }
  /// Creates a new [TraktUserSettings] instance.
  const TraktUserSettings({
    required this.user,
    required this.account,
    required this.connections,
    required this.sharingText,
  });

  /// User profile information.
  final TraktUser user;

  /// Account specific settings.
  final Map<String, dynamic> account;

  /// Social connections settings.
  final Map<String, dynamic> connections;

  /// Sharing settings.
  final Map<String, dynamic> sharingText;
}
