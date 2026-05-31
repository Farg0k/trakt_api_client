import 'trakt_ids.dart';
import 'trakt_user_images.dart';

/// Represents a user profile on Trakt.tv.
class TraktUser {

  /// Creates a new [TraktUser] instance.
  const TraktUser({
    required this.username,
    this.private,
    this.name,
    this.vip,
    this.vipEp,
    this.ids,
    this.joinedAt,
    this.location,
    this.about,
    this.gender,
    this.age,
    this.images,
  });

  /// Creates a [TraktUser] from a JSON map.
  factory TraktUser.fromJson(Map<String, dynamic> json) {
    return TraktUser(
      username: json['username'] as String? ?? '',
      private: json['private'] as bool?,
      name: json['name'] as String?,
      vip: json['vip'] as bool?,
      vipEp: json['vip_ep'] as bool?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at'] as String)
          : null,
      location: json['location'] as String?,
      about: json['about'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      images: json['images'] != null
          ? TraktUserImages.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }
  /// Username of the user.
  final String username;
  /// Whether the user has a private profile.
  final bool? private;
  /// Display name of the user.
  final String? name;
  /// Whether the user is a VIP member.
  final bool? vip;
  /// Whether the user is a VIP EP member.
  final bool? vipEp;
  /// IDs for the user (Trakt, etc.).
  final TraktIds? ids;
  /// When the user joined Trakt.
  final DateTime? joinedAt;
  /// Location of the user.
  final String? location;
  /// About text of the user.
  final String? about;
  /// Gender of the user.
  final String? gender;
  /// Age of the user.
  final int? age;
  /// Images for the user (avatars).
  final TraktUserImages? images;

  /// Converts this user to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      if (private != null) 'private': private,
      if (name != null) 'name': name,
      if (vip != null) 'vip': vip,
      if (vipEp != null) 'vip_ep': vipEp,
      if (ids != null) 'ids': ids!.toJson(),
      if (joinedAt != null) 'joined_at': joinedAt!.toIso8601String(),
      if (location != null) 'location': location,
      if (about != null) 'about': about,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (images != null) 'images': images!.toJson(),
    };
  }

  @override
  String toString() {
    return '''TraktUser{
      username: $username, 
      private: $private, 
      name: $name, 
      vip: $vip, 
      vipEp: $vipEp, 
      ids: $ids, 
      joinedAt: $joinedAt, 
      location: $location, 
      about: $about, 
      gender: $gender, 
      age: $age, 
      images: $images
    }''';
  }
}
