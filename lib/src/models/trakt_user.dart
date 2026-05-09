import '../core/trakt_date_utils.dart';

class TraktUser {
  const TraktUser({
    this.username,
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

  factory TraktUser.fromJson(Map<String, dynamic> json) {
    return TraktUser(
      username: json['username'] as String?,
      private: json['private'] as bool?,
      name: json['name'] as String?,
      vip: json['vip'] as bool?,
      vipEp: json['vip_ep'] as bool?,
      ids: json['ids'] != null
          ? TraktUserIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      joinedAt: TraktDateUtils.parse(json['joined_at']),
      location: json['location'] as String?,
      about: json['about'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
      images:
          (json['images'] as Map<String, dynamic>?)?['avatar']?['full']
              as String?,
    );
  }
  final String? username;
  final bool? private;
  final String? name;
  final bool? vip;
  final bool? vipEp;
  final TraktUserIds? ids;
  final DateTime? joinedAt;
  final String? location;
  final String? about;
  final String? gender;
  final int? age;
  final String? images;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'private': private,
      'name': name,
      'vip': vip,
      'vip_ep': vipEp,
      'ids': ids?.toJson(),
      'joined_at': joinedAt?.toIso8601String(),
      'location': location,
      'about': about,
      'gender': gender,
      'age': age,
    };
  }
}

class TraktUserIds {
  const TraktUserIds({required this.slug, this.uuid});

  factory TraktUserIds.fromJson(Map<String, dynamic> json) {
    return TraktUserIds(
      slug: json['slug'] as String? ?? '',
      uuid: json['uuid'] as String?,
    );
  }
  final String slug;
  final String? uuid;

  Map<String, dynamic> toJson() {
    return {'slug': slug, 'uuid': uuid};
  }
}
