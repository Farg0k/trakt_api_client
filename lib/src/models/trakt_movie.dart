import 'trakt_ids.dart';

class TraktMovie {
  final String? title;
  final int? year;
  final TraktIds? ids;
  final String? tagline;
  final String? overview;
  final double? rating;
  final int? votes;
  final String? certification;

  const TraktMovie({
    this.title,
    this.year,
    this.ids,
    this.tagline,
    this.overview,
    this.rating,
    this.votes,
    this.certification,
  });

  factory TraktMovie.fromJson(Map<String, dynamic> json) {
    return TraktMovie(
      title: json['title'] as String?,
      year: json['year'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      tagline: json['tagline'] as String?,
      overview: json['overview'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      certification: json['certification'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids?.toJson(),
      'tagline': tagline,
      'overview': overview,
      'rating': rating,
      'votes': votes,
      'certification': certification,
    };
  }
}
