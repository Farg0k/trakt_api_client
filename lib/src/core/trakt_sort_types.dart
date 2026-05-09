/// Sort types for comments.
enum TraktCommentSort {
  /// Sort by newest comments.
  newest('newest'),

  /// Sort by oldest comments.
  oldest('oldest'),

  /// Sort by comments with most likes.
  likes('likes'),

  /// Sort by comments with most likes in the last 30 days.
  likes30('likes_30'),

  /// Sort by comments with most replies.
  replies('replies'),

  /// Sort by comments with most replies in the last 30 days.
  replies30('replies_30'),

  /// Sort by plays.
  plays('plays'),

  /// Sort by rating.
  rating('rating'),

  /// Sort by when the comment was added.
  added('added');

  /// Creates a new [TraktCommentSort] instance.
  const TraktCommentSort(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}

/// Sort types for watchlists.
enum TraktWatchlistSort {
  /// Sort by rank.
  rank('rank'),

  /// Sort by when the item was added.
  added('added'),

  /// Sort by release date.
  released('released'),

  /// Sort by title.
  title('title');

  /// Creates a new [TraktWatchlistSort] instance.
  const TraktWatchlistSort(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}

/// Sort types for lists.
enum TraktListSort {
  /// Sort by popularity.
  popular('popular'),

  /// Sort by number of likes.
  likes('likes'),

  /// Sort by number of comments.
  comments('comments'),

  /// Sort by number of items.
  items('items'),

  /// Sort by when the list was added.
  added('added'),

  /// Sort by when the list was updated.
  updated('updated');

  /// Creates a new [TraktListSort] instance.
  const TraktListSort(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
