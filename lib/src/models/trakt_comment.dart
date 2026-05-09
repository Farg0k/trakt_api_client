import '../core/trakt_date_utils.dart';
import 'trakt_user.dart';

/// Represents a comment on a media object.
class TraktComment {

  /// Creates a new [TraktComment] instance.
  TraktComment({
    required this.id,
    required this.comment,
    required this.spoiler,
    this.createdAt,
    this.updatedAt,
    this.replies,
    this.likes,
    this.userRating,
    this.user,
  });

  /// Creates a [TraktComment] from a JSON map.
  factory TraktComment.fromJson(Map<String, dynamic> json) {
    return TraktComment(
      id: json['id'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      spoiler: json['spoiler'] as bool? ?? false,
      createdAt: TraktDateUtils.parse(json['created_at']),
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      replies: json['replies'] as int?,
      likes: json['likes'] as int?,
      userRating: json['user_rating'] as int?,
      user: json['user'] != null
          ? TraktUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
  /// Unique ID of the comment.
  final int id;
  /// Content of the comment.
  final String comment;
  /// Whether the comment contains spoilers.
  final bool spoiler;
  /// When the comment was created.
  final DateTime? createdAt;
  /// When the comment was last updated.
  final DateTime? updatedAt;
  /// Number of replies to this comment.
  final int? replies;
  /// Number of likes for this comment.
  final int? likes;
  /// Rating given by the user who commented.
  final int? userRating;
  /// The user who wrote the comment.
  final TraktUser? user;

  /// Converts this comment to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'comment': comment,
      'spoiler': spoiler,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'replies': replies,
      'likes': likes,
      'user_rating': userRating,
      'user': user?.toJson(),
    };
  }
}
