import 'trakt_ids.dart';

class TraktShow {
  final String? title;
  final int? year;
  final TraktIds? ids;
  final String? overview;
  final double? rating;
  final int? votes;
  final String? certification;
  final String? network;
  final String? status;

  const TraktShow({
    this.title,
    this.year,
    this.ids,
    this.overview,
    this.rating,
    this.votes,
    this.certification,
    this.network,
    this.status,
  });

  factory TraktShow.fromJson(Map<String, dynamic> json) {
    return TraktShow(
      title: json['title'] as String?,
      year: json['year'] as int?,
      ids: json['ids'] != null
          ? TraktIds.fromJson(json['ids'] as Map<String, dynamic>)
          : null,
      overview: json['overview'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      votes: json['votes'] as int?,
      certification: json['certification'] as String?,
      network: json['network'] as String?,
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'year': year,
      'ids': ids?.toJson(),
      'overview': overview,
      'rating': rating,
      'votes': votes,
      'certification': certification,
      'network': network,
      'status': status,
    };
  }
}
