class TraktIds {
  TraktIds({
    this.trakt,
    this.slug,
    this.imdb,
    this.tmdb,
    this.tvdb,
    this.tvrage,
    this.uuid,
  });

  factory TraktIds.fromJson(Map<String, dynamic> json) {
    return TraktIds(
      trakt: json['trakt'] as int?,
      slug: json['slug'] as String?,
      imdb: json['imdb'] as String?,
      tmdb: json['tmdb'] as int?,
      tvdb: json['tvdb'] as int?,
      tvrage: json['tvrage'] as int?,
      uuid: json['uuid'] as String?,
    );
  }
  final int? trakt;
  final String? slug;
  final String? imdb;
  final int? tmdb;
  final int? tvdb;
  final int? tvrage;
  final String? uuid;

  Map<String, dynamic> toJson() {
    return {
      'trakt': trakt,
      'slug': slug,
      'imdb': imdb,
      'tmdb': tmdb,
      'tvdb': tvdb,
      'tvrage': tvrage,
      'uuid': uuid,
    };
  }
}
