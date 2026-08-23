import '../core/trakt_date_utils.dart';
import 'trakt_user.dart';

/// Represents a user note.
class TraktNote {
  /// Creates a new [TraktNote] instance.
  const TraktNote({
    required this.id,
    required this.note,
    required this.privacy,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  /// Creates a [TraktNote] from a JSON map.
  factory TraktNote.fromJson(Map<String, dynamic> json) {
    return TraktNote(
      id: json['id'] as int? ?? 0,
      note: json['note'] as String? ?? '',
      privacy: json['privacy'] as String? ?? 'private',
      createdAt: TraktDateUtils.parse(json['created_at']),
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      user: json['user'] != null
          ? TraktUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Unique ID of the note.
  final int id;

  /// Content of the note.
  final String note;

  /// Privacy setting of the note.
  final String privacy;

  /// When the note was created.
  final DateTime? createdAt;

  /// When the note was last updated.
  final DateTime? updatedAt;

  /// The user who wrote the note.
  final TraktUser? user;

  /// Converts this note to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'note': note,
      'privacy': privacy,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      if (user != null) 'user': user!.toJson(),
    };
  }

  @override
  String toString() {
    return '''TraktNote{
      id: $id, 
      note: $note, 
      privacy: $privacy, 
      createdAt: $createdAt, 
      updatedAt: $updatedAt, 
      user: $user
    }''';
  }
}
