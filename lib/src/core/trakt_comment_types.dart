/// Types of comments that can be filtered.
enum TraktCommentType {
  /// All comments.
  all('all'),
  /// Comments from the user's friends.
  reviews('reviews'),
  /// Comments that are shouts.
  shouts('shouts');
  /// Creates a new [TraktCommentType] instance.
  const TraktCommentType(this.value);
  /// The value used in API requests.
  final String value;

}

/// Sort types for comments.
enum TraktCommentSort {
  /// Sort by newest comments.
  newest('newest'),
  /// Sort by oldest comments.
  oldest('oldest'),
  /// Sort by comments with most likes.
  likes('likes'),
  /// Sort by comments with most replies.
  replies('replies');
  /// Creates a new [TraktCommentSort] instance.
  const TraktCommentSort(this.value);
  /// The value used in API requests.
  final String value;
}
