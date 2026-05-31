import '../core/trakt_privacy.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_ids.dart';
import 'trakt_user.dart';
import 'trakt_movie.dart';
import 'trakt_show.dart';
import 'trakt_season.dart';
import 'trakt_episode.dart';
import 'trakt_person.dart';

/// Represents a Trakt list.
class TraktList {
  /// Creates a new [TraktList] instance.
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

  /// Creates a [TraktList] from a JSON map.
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
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? TraktUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Name of the list.
  final String name;

  /// Optional description.
  final String? description;

  /// Privacy setting.
  final TraktPrivacy privacy;

  /// Whether to display item numbers.
  final bool displayNumbers;

  /// Whether to allow comments.
  final bool allowComments;

  /// Current sort field.
  final String? sortBy;

  /// Current sort direction.
  final String? sortHow;

  /// When the list was created.
  final DateTime? createdAt;

  /// When the list was last updated.
  final DateTime? updatedAt;

  /// Number of items in the list.
  final int? itemCount;

  /// Number of comments.
  final int? commentCount;

  /// Number of likes.
  final int? likes;

  /// IDs for the list.
  final TraktIds? ids;

  /// The owner of the list.
  final TraktUser? user;

  /// Converts this list to a JSON map.
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

/// Represents an item within a Trakt list.
class TraktListItem {
  /// Creates a new [TraktListItem] instance.
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

  /// Creates a [TraktListItem] from a JSON map.
  factory TraktListItem.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return TraktListItem(
      rank: json['rank'] as int?,
      id: json['id'] as int? ?? 0,
      listedAt: TraktDateUtils.parse(json['listed_at']),
      notes: json['notes'] as String?,
      type: type,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      show: json['show'] != null
          ? TraktShow.fromJson(json['show'] as Map<String, dynamic>)
          : null,
      season: json['season'] != null
          ? TraktSeason.fromJson(json['season'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
      person: json['person'] != null
          ? TraktPerson.fromJson(json['person'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Rank of the item in the list.
  final int? rank;

  /// Unique ID of the list item.
  final int id;

  /// When the item was added to the list.
  final DateTime? listedAt;

  /// Optional user notes.
  final String? notes;

  /// Type of the item.
  final String type;

  /// Movie object (if type is movie).
  final TraktMovie? movie;

  /// Show object (if type is show).
  final TraktShow? show;

  /// Season object (if type is season).
  final TraktSeason? season;

  /// Episode object (if type is episode).
  final TraktEpisode? episode;

  /// Person object (if type is person).
  final TraktPerson? person;

  /// Converts this list item to a JSON map.
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
