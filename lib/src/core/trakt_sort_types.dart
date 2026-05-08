enum TraktCommentSort {
  newest('newest'),
  oldest('oldest'),
  likes('likes'),
  likes30('likes_30'),
  replies('replies'),
  replies30('replies_30'),
  plays('plays'),
  rating('rating'),
  added('added');

  final String value;
  const TraktCommentSort(this.value);

  @override
  String toString() => value;
}

enum TraktWatchlistSort {
  rank('rank'),
  added('added'),
  released('released'),
  title('title');

  final String value;
  const TraktWatchlistSort(this.value);

  @override
  String toString() => value;
}

enum TraktListSort {
  popular('popular'),
  likes('likes'),
  comments('comments'),
  items('items'),
  added('added'),
  updated('updated');

  final String value;
  const TraktListSort(this.value);

  @override
  String toString() => value;
}
