import 'trakt_show.dart';

class TraktShowUpdate {
  final DateTime updatedAt;
  final TraktShow show;

  const TraktShowUpdate({
    required this.updatedAt,
    required this.show,
  });

  factory TraktShowUpdate.fromJson(Map<String, dynamic> json) {
    return TraktShowUpdate(
      updatedAt: DateTime.parse(json['updated_at'] as String),
      show: TraktShow.fromJson(json['show'] as Map<String, dynamic>),
    );
  }
}

class TraktShowStats {
  final int watchers;
  final int plays;
  final int collectors;
  final int collectorsEpisodes;
  final int comments;
  final int lists;
  final int votes;

  const TraktShowStats({
    required this.watchers,
    required this.plays,
    required this.collectors,
    required this.collectorsEpisodes,
    required this.comments,
    required this.lists,
    required this.votes,
  });

  factory TraktShowStats.fromJson(Map<String, dynamic> json) {
    return TraktShowStats(
      watchers: json['watchers'] as int,
      plays: json['plays'] as int,
      collectors: json['collectors'] as int,
      collectorsEpisodes: json['collected_episodes'] as int,
      comments: json['comments'] as int,
      lists: json['lists'] as int,
      votes: json['votes'] as int,
    );
  }
}

class TraktShowAlias {
  final String title;
  final String country;

  const TraktShowAlias({
    required this.title,
    required this.country,
  });

  factory TraktShowAlias.fromJson(Map<String, dynamic> json) {
    return TraktShowAlias(
      title: json['title'] as String,
      country: json['country'] as String,
    );
  }
}
