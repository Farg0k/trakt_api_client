import 'trakt_movie.dart';
import 'trakt_show.dart';

class TraktPersonMovieCredits {
  final List<TraktPersonCredit<TraktMovie>>? cast;
  final Map<String, List<TraktPersonCredit<TraktMovie>>>? crew;

  const TraktPersonMovieCredits({this.cast, this.crew});

  factory TraktPersonMovieCredits.fromJson(Map<String, dynamic> json) {
    return TraktPersonMovieCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktPersonCredit<TraktMovie>.fromJson(e as Map<String, dynamic>, TraktMovie.fromJson, 'movie'))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => TraktPersonCredit<TraktMovie>.fromJson(e as Map<String, dynamic>, TraktMovie.fromJson, 'movie'))
              .toList(),
        ),
      ),
    );
  }
}

class TraktPersonShowCredits {
  final List<TraktPersonCredit<TraktShow>>? cast;
  final Map<String, List<TraktPersonCredit<TraktShow>>>? crew;

  const TraktPersonShowCredits({this.cast, this.crew});

  factory TraktPersonShowCredits.fromJson(Map<String, dynamic> json) {
    return TraktPersonShowCredits(
      cast: (json['cast'] as List?)
          ?.map((e) => TraktPersonCredit<TraktShow>.fromJson(e as Map<String, dynamic>, TraktShow.fromJson, 'show'))
          .toList(),
      crew: (json['crew'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          (value as List)
              .map((e) => TraktPersonCredit<TraktShow>.fromJson(e as Map<String, dynamic>, TraktShow.fromJson, 'show'))
              .toList(),
        ),
      ),
    );
  }
}

class TraktPersonCredit<T> {
  final List<String>? characters;
  final String? job;
  final T item;

  const TraktPersonCredit({this.characters, this.job, required this.item});

  factory TraktPersonCredit.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktPersonCredit(
      characters: (json['characters'] as List?)?.map((e) => e as String).toList(),
      job: json['job'] as String?,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}
