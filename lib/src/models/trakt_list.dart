import '../core/trakt_privacy.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_ids.dart';
import 'trakt_user.dart';
import 'trakt_movie.dart';
import 'trakt_show.dart';
import 'trakt_season.dart';
import 'trakt_episode.dart';
import 'trakt_person.dart';

class TraktList {
  final String name;
  final String? description;
  final TraktPrivacy privacy;
  final bool displayNumbers;
  final bool allowComments;
  final String? sortBy;
  final String? sortHow;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? itemCount;
  final int? commentCount;
  final int? likes;
  final TraktIds? ids;
  final TraktUser? user;

  const TraktList({
    required this.name,
    this.description,
    this.privacy = TraktPrivacy.private,
    this.displayNumbers = false,
    this.allowComments = true,
    this.sortBy,
    this.sortHow,
    this.createdAt,
    this.updatedAt,
    this.itemCount,
    this.commentCount,
    this.likes,
    this.ids,
    this.user,
  });

  factory TraktList.fromJson(Map<String, dynamic> json) {
    return TraktList(
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      privacy: TraktPrivacy.fromString(json['privacy'] as String?),
      displayNumbers: json['display_numbers'] as bool? ?? false,
      allowComments: json['allow_comments'] as bool? ?? true,
      sortBy: json['sort_by'] as String?,
      sortHow: json['sort_how'] as String?,
      createdAt: TraktDateUtils.parse(json['created_at']),
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      itemCount: json['item_count'] as int?,
      commentCount: json['comment_count'] as int?,
      likes: json['likes'] as int?,
      ids: json['ids'] != null ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>) : null,
      user: json['user'] != null ? TraktUser.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'privacy': privacy.value,
      'display_numbers': displayNumbers,
      'allow_comments': allowComments,
      if (sortBy != null) 'sort_by': sortBy,
      if (sortHow != null) 'sort_how': sortHow,
    };
  }
}

class TraktListItem {
  final int? rank;
  final int id;
  final DateTime? listedAt;
  final String? notes;
  final String type;
  final TraktMovie? movie;
  final TraktShow? show;
  final TraktSeason? season;
  final TraktEpisode? episode;
  final TraktPerson? person;

  const TraktListItem({
    this.rank,
    required this.id,
    this.listedAt,
    this.notes,
    required this.type,
    this.movie,
    this.show,
    this.season,
    this.episode,
    this.person,
  });

  factory TraktListItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktListItem(
      rank: json['rank'] as int?,
      id: json['id'] as int? ?? 0,
      listedAt: TraktDateUtils.parse(json['listed_at']),
      notes: json['notes'] as String?,
      type: type,
      movie: type == 'movie' && json['movie'] != null ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>) : null,
      show: type == 'show' && json['show'] != null ? TraktShow.fromJson(json['show'] as Map<String, dynamic>) : null,
      season: type == 'season' && json['season'] != null ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>) : null,
      episode: type == 'episode' && json['episode'] != null ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>) : null,
      person: type == 'person' && json['person'] != null ? TraktPerson.fromJson(json['person'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'id': id,
      'listed_at': listedAt?.toIso8601String(),
      'notes': notes,
      'type': type,
      if (movie != null) 'movie': movie!.toJson(),
      if (show != null) 'show': show!.toJson(),
      if (season != null) 'season': season!.toJson(),
      if (episode != null) 'episode': episode!.toJson(),
      if (person != null) 'person': person!.toJson(),
    };
  }
}
