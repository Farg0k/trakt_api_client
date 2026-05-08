import '../core/trakt_privacy.dart';
import '../core/trakt_date_utils.dart';
import 'trakt_ids.dart';
import 'trakt_user.dart';

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

  TraktList({
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
