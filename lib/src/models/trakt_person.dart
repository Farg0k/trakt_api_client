import 'trakt_ids.dart';

/// Represents a person (actor, crew member).
class TraktPerson {

  /// Creates a [TraktPerson] from a JSON map.
  factory TraktPerson.fromJson(Map<String, dynamic> json) {
    return TraktPerson(
      name: json['name'] as String? ?? '',
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
    );
  }

  /// Creates a new [TraktPerson] instance.
  const TraktPerson({
    required this.name,
    this.ids,
    this.biography,
    this.birthday,
    this.death,
    this.birthplace,
    this.homepage,
  });
  /// Name of the person.
  final String name;
  /// IDs for the person (Trakt, TMDB, etc.).
  final TraktIds? ids;
  /// Biography of the person.
  final String? biography;
  /// Birthday of the person.
  final DateTime? birthday;
  /// Death day of the person (if applicable).
  final DateTime? death;
  /// Birthplace of the person.
  final String? birthplace;
  /// Official website URL.
  final String? homepage;

  /// Converts this person to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (ids != null) 'ids': ids!.toJson(),
      'biography': biography,
      'birthday': birthday?.toIso8601String(),
      'death': death?.toIso8601String(),
      'birthplace': birthplace,
      'homepage': homepage,
    };
  }

  @override
  String toString() {
    return '''TraktPerson{
      name: $name, 
      ids: $ids, 
      biography: $biography, 
      birthday: $birthday, 
      death: $death, 
      birthplace: $birthplace, 
      homepage: $homepage
    }''';
  }
}
