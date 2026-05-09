/// IDs for any media object (Movie, Show, Season, Episode, Person).
class TraktIds {

  /// Creates a new [TraktIds] instance.
  const TraktIds({
    this.trakt,
    this.slug,
    this.imdb,
    this.tmdb,
    this.tvdb,
    this.tvrage,
    this.uuid,
  });

  /// Creates a [TraktIds] from a JSON map.
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
  /// Trakt numeric ID.
  final int? trakt;
  /// Trakt URL slug.
  final String? slug;
  /// IMDB ID (tt...).
  final String? imdb;
  /// TMDB numeric ID.
  final int? tmdb;
  /// TVDB numeric ID.
  final int? tvdb;
  /// TVRage numeric ID.
  final int? tvrage;
  /// UUID for the object.
  final String? uuid;

  /// Converts these IDs to a JSON map.
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
