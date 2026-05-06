import 'trakt_ids.dart';

class TraktStudio {
  final String name;
  final TraktIds ids;

  const TraktStudio({
    required this.name,
    required this.ids,
  });

  factory TraktStudio.fromJson(Map<String, dynamic> json) {
    return TraktStudio(
      name: json['name'] as String,
      ids: TraktIds.fromJson(json['ids'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ids': ids.toJson(),
    };
  }
}
