import 'trakt_user_images.dart';

/// Account settings from /users/settings endpoint.
class TraktUserAccount {
  /// Creates a [TraktUserAccount] from a JSON map.
  factory TraktUserAccount.fromJson(Map<String, dynamic> json) {
    return TraktUserAccount(
      username: json['username'] as String? ?? '',
      private: json['private'] as bool?,
      vip: json['vip'] as bool?,
      vipEp: json['vip_ep'] as bool?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      location: json['location'] as String?,
      about: json['about'] as String?,
      joinedAt: json['joined_at'] != null
          ? DateTime.tryParse(json['joined_at'] as String)
          : null,
      images: json['images'] != null
          ? TraktUserImages.fromJson(json['images'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Creates a new [TraktUserAccount] instance.
  const TraktUserAccount({
    required this.username,
    this.private,
    this.vip,
    this.vipEp,
    this.email,
    this.name,
    this.gender,
    this.age,
    this.location,
    this.about,
    this.joinedAt,
    this.images,
  });

  /// Username.
  final String username;

  /// Whether profile is private.
  final bool? private;

  /// VIP status.
  final bool? vip;

  /// VIP EP status.
  final bool? vipEp;

  /// Email address.
  final String? email;

  /// Display name.
  final String? name;

  /// Gender.
  final String? gender;

  /// Age.
  final int? age;

  /// Location.
  final String? location;

  /// About/bio text.
  final String? about;

  /// When account was created.
  final DateTime? joinedAt;

  /// Avatar images.
  final TraktUserImages? images;

  /// Converts to JSON.
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      if (private != null) 'private': private,
      if (vip != null) 'vip': vip,
      if (vipEp != null) 'vip_ep': vipEp,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (location != null) 'location': location,
      if (about != null) 'about': about,
      if (joinedAt != null) 'joined_at': joinedAt!.toIso8601String(),
      if (images != null) 'images': images!.toJson(),
    };
  }

  @override
  String toString() {
    return '''TraktUserAccount{
      username: $username, 
      private: $private, 
      vip: $vip, 
      vipEp: $vipEp, 
      email: $email, 
      name: $name, 
      gender: $gender, 
      age: $age, 
      location: $location, 
      about: $about, 
      joinedAt: $joinedAt, 
      images: $images
    }''';
  }
}
