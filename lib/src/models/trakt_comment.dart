import 'trakt_user.dart';

class TraktComment {
  final int id;
  final int? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String comment;
  final bool spoiler;
  final bool review;
  final int replies;
  final int likes;
  final int? userRating;
  final TraktUser? user;

  const TraktComment({
    required this.id,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.comment,
    required this.spoiler,
    required this.review,
    required this.replies,
    required this.likes,
    this.userRating,
    this.user,
  });

  factory TraktComment.fromJson(Map<String, dynamic> json) {
    return TraktComment(
      id: json['id'] as int,
      parentId: json['parent_id'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      comment: json['comment'] as String,
      spoiler: json['spoiler'] as bool,
      review: json['review'] as bool,
      replies: json['replies'] as int,
      likes: json['likes'] as int,
      userRating: json['user_rating'] as int?,
      user: json['user'] != null
          ? TraktUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parent_id': parentId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'comment': comment,
      'spoiler': spoiler,
      'review': review,
      'replies': replies,
      'likes': likes,
      'user_rating': userRating,
      'user': user?.toJson(),
    };
  }
}
