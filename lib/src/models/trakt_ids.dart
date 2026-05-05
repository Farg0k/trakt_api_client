class TraktIds {
  final int? trakt;
  final String? slug;
  final String? imdb;
  final int? tmdb;
  final int? tvdb;

  const TraktIds({
    this.trakt,
    this.slug,
    this.imdb,
    this.tmdb,
    this.tvdb,
  });

  factory TraktIds.fromJson(Map<String, dynamic> json) {
    return TraktIds(
      trakt: json['trakt'] as int?,
      slug: json['slug'] as String?,
      imdb: json['imdb'] as String?,
      tmdb: json['tmdb'] as int?,
      tvdb: json['tvdb'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'trakt': trakt,
      'slug': slug,
      'imdb': imdb,
      'tmdb': tmdb,
      'tvdb': tvdb,
    };
  }
}
