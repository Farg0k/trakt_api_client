import 'trakt_movie.dart';
import 'trakt_person.dart';
import 'trakt_show.dart';

/// Movie credits for a person.
class TraktPersonMovieCredits {

  /// Creates a new [TraktPersonMovieCredits] instance.
  const TraktPersonMovieCredits({this.cast, this.crew});

  /// Creates a [TraktPersonMovieCredits] from a JSON map.
  factory TraktPersonMovieCredits.fromJson(Map<String, dynamic> json) {
    return TraktPersonMovieCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktPersonCredit<TraktMovie>.fromJson(
              e as Map<String, dynamic>, TraktMovie.fromJson, 'movie'))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => TraktPersonCredit<TraktMovie>.fromJson(
                  e as Map<String, dynamic>, TraktMovie.fromJson, 'movie'))
              .toList(),
        ),
      ),
    );
  }
  /// List of cast credits.
  final List<TraktPersonCredit<TraktMovie>>? cast;
  /// Map of crew credits grouped by department.
  final Map<String, List<TraktPersonCredit<TraktMovie>>>? crew;
}

/// Show credits for a person.
class TraktPersonShowCredits {

  /// Creates a new [TraktPersonShowCredits] instance.
  const TraktPersonShowCredits({this.cast, this.crew});

  /// Creates a [TraktPersonShowCredits] from a JSON map.
  factory TraktPersonShowCredits.fromJson(Map<String, dynamic> json) {
    return TraktPersonShowCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktPersonCredit<TraktShow>.fromJson(
              e as Map<String, dynamic>, TraktShow.fromJson, 'show'))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => TraktPersonCredit<TraktShow>.fromJson(
                  e as Map<String, dynamic>, TraktShow.fromJson, 'show'))
              .toList(),
        ),
      ),
    );
  }
  /// List of cast credits.
  final List<TraktPersonCredit<TraktShow>>? cast;
  /// Map of crew credits grouped by department.
  final Map<String, List<TraktPersonCredit<TraktShow>>>? crew;
}

/// Generic credit information for a person.
class TraktPersonCredit<T> {

  /// Creates a new [TraktPersonCredit] instance.
  const TraktPersonCredit({this.characters, this.job, required this.item});

  /// Creates a [TraktPersonCredit] from a JSON map.
  factory TraktPersonCredit.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktPersonCredit(
      characters:
          (json['characters'] as List?)?.map((e) => e as String).toList(),
      job: json['job'] as String?,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// Characters played by the person.
  final List<String>? characters;
  /// Job performed by the person.
  final String? job;
  /// The media item (Movie or Show).
  final T item;
}

/// Information about a person's profile update.
class TraktPersonUpdate {

  /// Creates a new [TraktPersonUpdate] instance.
  const TraktPersonUpdate({required this.updatedAt, required this.person});

  /// Creates a [TraktPersonUpdate] from a JSON map.
  factory TraktPersonUpdate.fromJson(Map<String, dynamic> json) {
    return TraktPersonUpdate(
      updatedAt: DateTime.parse(json['updated_at'] as String),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
  /// When the profile was updated.
  final DateTime updatedAt;
  /// The person object.
  final TraktPerson person;
}

/// Information about a deleted person.
class TraktDeletedPerson {

  /// Creates a new [TraktDeletedPerson] instance.
  const TraktDeletedPerson({required this.deletedAt, required this.person});

  /// Creates a [TraktDeletedPerson] from a JSON map.
  factory TraktDeletedPerson.fromJson(Map<String, dynamic> json) {
    return TraktDeletedPerson(
      deletedAt: DateTime.parse(json['deleted_at'] as String),
      person: TraktPerson.fromJson(json['person'] as Map<String, dynamic>),
    );
  }
  /// When the person was deleted.
  final DateTime deletedAt;
  /// The person object.
  final TraktPerson person;
}
