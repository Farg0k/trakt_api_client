class TraktStats {
  final int watchers;
  final int plays;
  final int collectors;
  final int? collectedEpisodes;
  final int comments;
  final int lists;
  final int votes;

  const TraktStats({
    required this.watchers,
    required this.plays,
    required this.collectors,
    this.collectedEpisodes,
    required this.comments,
    required this.lists,
    required this.votes,
  });

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
}
