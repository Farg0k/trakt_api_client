enum TraktCommentType {
  all('all'),
  reviews('reviews'),
  shouts('shouts');

  final String value;
  const TraktCommentType(this.value);

  @override
  String toString() => value;
}
