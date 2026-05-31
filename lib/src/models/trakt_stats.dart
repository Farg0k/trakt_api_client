/// General statistics for a media object.
class TraktStats {

  /// Creates a [TraktStats] from a JSON map.
  factory TraktStats.fromJson(Map<String, dynamic> json) {
    return TraktStats(
      watchers: json['watchers'] as int? ?? 0,
      plays: json['plays'] as int? ?? 0,
      collectors: json['collectors'] as int? ?? 0,
      collectedEpisodes: json['collected_episodes'] as int?,
      comments: json['comments'] as int? ?? 0,
      lists: json['lists'] as int? ?? 0,
      votes: json['votes'] as int? ?? 0,
    );
  }
  /// Creates a new [TraktStats] instance.
  const TraktStats({
    required this.watchers,
    required this.plays,
    required this.collectors,
    this.collectedEpisodes,
    required this.comments,
    required this.lists,
    required this.votes,
  });

  /// Number of users who have watched the item.
  final int watchers;

  /// Total number of plays.
  final int plays;

  /// Number of users who have the item in their collection.
  final int collectors;

  /// Number of collected episodes (for shows).
  final int? collectedEpisodes;

  /// Number of comments.
  final int comments;

  /// Number of lists containing the item.
  final int lists;

  /// Total number of votes.
  final int votes;

  /// Converts these statistics to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'watchers': watchers,
      'plays': plays,
      'collectors': collectors,
      if (collectedEpisodes != null) 'collected_episodes': collectedEpisodes,
      'comments': comments,
      'lists': lists,
      'votes': votes,
    };
  }

  @override
  String toString() {
    return '''TraktStats{
      watchers: $watchers, 
      plays: $plays, 
      collectors: $collectors, 
      collectedEpisodes: $collectedEpisodes, 
      comments: $comments, 
      lists: $lists, 
      votes: $votes
    }''';
  }
}
