import '../core/trakt_date_utils.dart';
import 'trakt_user.dart';

class TraktComment {
  final int id;
  final String comment;
  final bool spoiler;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? replies;
  final int? likes;
  final int? userRating;
  final TraktUser? user;

  const TraktComment({
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
