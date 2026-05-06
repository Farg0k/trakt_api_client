import 'trakt_ids.dart';
import 'trakt_user_models.dart';

class TraktPerson {
  final String? name;
  final TraktIds? ids;
  final String? biography;
  final DateTime? birthday;
  final DateTime? death;
  final String? birthplace;
  final String? homepage;
  final String? gender;
  final String? knownForDepartment;
  final TraktUserSocialIds? socialIds;

  const TraktPerson({
    this.name,
    this.ids,
    this.biography,
    this.birthday,
    this.death,
    this.birthplace,
    this.homepage,
    this.gender,
    this.knownForDepartment,
    this.socialIds,
  });

  factory TraktPerson.fromJson(Map<String, dynamic> json) {
    return TraktPerson(
      name: json['name'] as String?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      biography: json['biography'] as String?,
      birthday: json['birthday'] != null
          ? DateTime.tryParse(json['birthday'] as String)
          : null,
      death: json['death'] != null
          ? DateTime.tryParse(json['death'] as String)
          : null,
      birthplace: json['birthplace'] as String?,
      homepage: json['homepage'] as String?,
      gender: json['gender'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      socialIds: json['social_ids'] != null
          ? TraktUserSocialIds.fromJson(json['social_ids'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ids': ids?.toJson(),
      'biography': biography,
      'birthday': birthday?.toIso8601String(),
      'death': death?.toIso8601String(),
      'birthplace': birthplace,
      'homepage': homepage,
      'gender': gender,
      'known_for_department': knownForDepartment,
      'social_ids': socialIds?.toJson(),
    };
  }
}
