import 'trakt_ids.dart';
import 'trakt_user.dart';

class TraktList {
  final String? name;
  final String? description;
  final String? privacy;
  final String? type;
  final bool? displayNumbers;
  final bool? allowComments;
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
    this.name,
    this.description,
    this.privacy,
    this.type,
    this.displayNumbers,
    this.allowComments,
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
      name: json['name'] as String?,
      description: json['description'] as String?,
      privacy: json['privacy'] as String?,
      type: json['type'] as String?,
      displayNumbers: json['display_numbers'] as bool?,
      allowComments: json['allow_comments'] as bool?,
      sortBy: json['sort_by'] as String?,
      sortHow: json['sort_how'] as String?,
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'] as String) : null,
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at'] as String) : null,
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
      'privacy': privacy,
      'type': type,
      'display_numbers': displayNumbers,
      'allow_comments': allowComments,
      'sort_by': sortBy,
      'sort_how': sortHow,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'item_count': itemCount,
      'comment_count': commentCount,
      'likes': likes,
      'ids': ids?.toJson(),
      'user': user?.toJson(),
    };
  }
}
