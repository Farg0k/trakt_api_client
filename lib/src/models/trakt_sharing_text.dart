/// Sharing text templates for different media types.
class TraktSharingText {
  /// Creates a [TraktSharingText] from a JSON map.
  factory TraktSharingText.fromJson(Map<String, dynamic> json) {
    return TraktSharingText(
      movie: json['movie'] != null
          ? TraktSharingTextTemplate.fromJson(
              json['movie'] as Map<String, dynamic>,
            )
          : null,
      show: json['show'] != null
          ? TraktSharingTextTemplate.fromJson(
              json['show'] as Map<String, dynamic>,
            )
          : null,
      episode: json['episode'] != null
          ? TraktSharingTextTemplate.fromJson(
              json['episode'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// Creates a new [TraktSharingText] instance.
  const TraktSharingText({this.movie, this.show, this.episode});

  /// Movie sharing templates.
  final TraktSharingTextTemplate? movie;

  /// Show sharing templates.
  final TraktSharingTextTemplate? show;

  /// Episode sharing templates.
  final TraktSharingTextTemplate? episode;

  /// Converts to JSON.
  Map<String, dynamic> toJson() {
    return {
      if (movie != null) 'movie': movie!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
    };
  }

  @override
  String toString() {
    return '''TraktSharingText{
      movie: $movie, 
      show: $show, 
      episode: $episode
    }''';
  }
}

/// Template strings for a specific media type.
class TraktSharingTextTemplate {
  /// Creates a [TraktSharingTextTemplate] from a JSON map.
  factory TraktSharingTextTemplate.fromJson(Map<String, dynamic> json) {
    return TraktSharingTextTemplate(
      watching: json['watching'] as String?,
      watched: json['watched'] as String?,
      rating: json['rating'] as String?,
      review: json['review'] as String?,
      addToWatchlist: json['add_to_watchlist'] as String?,
      addedToWatchlist: json['added_to_watchlist'] as String?,
      collected: json['collected'] as String?,
      watchlist: json['watchlist'] as String?,
    );
  }

  /// Creates a new [TraktSharingTextTemplate] instance.
  const TraktSharingTextTemplate({
    this.watching,
    this.watched,
    this.rating,
    this.review,
    this.addToWatchlist,
    this.addedToWatchlist,
    this.collected,
    this.watchlist,
  });

  /// Template for "watching" status.
  final String? watching;

  /// Template for "watched" status.
  final String? watched;

  /// Template for rating.
  final String? rating;

  /// Template for review.
  final String? review;

  /// Template for adding to watchlist.
  final String? addToWatchlist;

  /// Template for watchlist addition confirmation.
  final String? addedToWatchlist;

  /// Template for collection.
  final String? collected;

  /// Template for watchlist (legacy).
  final String? watchlist;

  /// Converts to JSON.
  Map<String, dynamic> toJson() {
    return {
      if (watching != null) 'watching': watching,
      if (watched != null) 'watched': watched,
      if (rating != null) 'rating': rating,
      if (review != null) 'review': review,
      if (addToWatchlist != null) 'add_to_watchlist': addToWatchlist,
      if (addedToWatchlist != null) 'added_to_watchlist': addedToWatchlist,
      if (collected != null) 'collected': collected,
      if (watchlist != null) 'watchlist': watchlist,
    };
  }

  @override
  String toString() {
    return '''TraktSharingTextTemplate{
      watching: $watching, 
      watched: $watched, 
      rating: $rating, 
      review: $review, 
      addToWatchlist: $addToWatchlist, 
      addedToWatchlist: $addedToWatchlist, 
      collected: $collected, 
      watchlist: $watchlist
    }''';
  }
}
