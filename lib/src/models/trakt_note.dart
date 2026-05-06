import '../core/trakt_privacy.dart';
import 'trakt_user.dart';

class TraktNote {
  final int id;
  final String note;
  final TraktPrivacy privacy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TraktUser? user;

  const TraktNote({
    required this.id,
    required this.note,
    required this.privacy,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory TraktNote.fromJson(Map<String, dynamic> json) {
    return TraktNote(
      id: json['id'] as int,
      note: json['note'] as String,
      privacy: TraktPrivacy.fromString(json['privacy'] as String?),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      user: json['user'] != null
          ? TraktUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'privacy': privacy.name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user?.toJson(),
    };
  }
}
