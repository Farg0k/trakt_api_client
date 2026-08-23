import '../core/trakt_date_utils.dart';
import 'trakt_media_metadata.dart';

/// Generic model for user's watched/collected items.
class TraktMediaState<T> {
  /// Creates a new [TraktMediaState] instance.
  const TraktMediaState({
    this.plays,
    this.lastWatchedAt,
    this.lastCollectedAt,
    this.lastUpdatedAt,
    required this.item,
    this.seasons,
    this.metadata,
  });

  /// Creates a [TraktMediaState] from a JSON map.
  factory TraktMediaState.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
    String itemKey,
  ) {
    return TraktMediaState(
      plays: json['plays'] as int?,
      lastWatchedAt: TraktDateUtils.parse(json['last_watched_at']),
      lastCollectedAt: TraktDateUtils.parse(json['last_collected_at']),
      lastUpdatedAt: TraktDateUtils.parse(json['last_updated_at']),
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
      metadata: json['metadata'] != null
          ? TraktMediaMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>,
            )
          : null,
      seasons: json['seasons'] != null
          ? (json['seasons'] as List)
                .map(
                  (e) => TraktSeasonState.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  /// Number of plays.
  final int? plays;

  /// When the item was last watched.
  final DateTime? lastWatchedAt;

  /// When the item was last collected.
  final DateTime? lastCollectedAt;

  /// When the state was last updated.
  final DateTime? lastUpdatedAt;

  /// The media item (Movie or Show).
  final T item;

  /// Progress by season (for shows).
  final List<TraktSeasonState>? seasons;

  /// Optional metadata about the collection state.
  final TraktMediaMetadata? metadata;

  @override
  String toString() {
    return '''TraktMediaState{
      plays: $plays, 
      lastWatchedAt: $lastWatchedAt, 
      lastCollectedAt: $lastCollectedAt, 
      lastUpdatedAt: $lastUpdatedAt, 
      item: $item, 
      seasons: $seasons, 
      metadata: $metadata
    }''';
  }
}

/// Progress state for a single season.
class TraktSeasonState {
  /// Creates a new [TraktSeasonState] instance.
  const TraktSeasonState({required this.number, required this.episodes});

  /// Creates a [TraktSeasonState] from a JSON map.
  factory TraktSeasonState.fromJson(Map<String, dynamic> json) {
    return TraktSeasonState(
      number: json['number'] as int? ?? 0,
      episodes: (json['episodes'] as List? ?? [])
          .map((e) => TraktEpisodeState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Season number.
  final int number;

  /// Progress state for episodes in this season.
  final List<TraktEpisodeState> episodes;

  @override
  String toString() {
    return '''TraktSeasonState{
      number: $number, 
      episodes: $episodes
    }''';
  }
}

/// Progress state for a single episode.
class TraktEpisodeState {
  /// Creates a new [TraktEpisodeState] instance.
  const TraktEpisodeState({
    required this.number,
    this.plays,
    this.lastWatchedAt,
    this.collectedAt,
    this.metadata,
  });

  /// Creates a [TraktEpisodeState] from a JSON map.
  factory TraktEpisodeState.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeState(
      number: json['number'] as int? ?? 0,
      plays: json['plays'] as int?,
      lastWatchedAt: TraktDateUtils.parse(json['last_watched_at']),
      collectedAt: TraktDateUtils.parse(json['collected_at']),
      metadata: json['metadata'] != null
          ? TraktMediaMetadata.fromJson(
              json['metadata'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  /// Episode number.
  final int number;

  /// Number of plays for this episode.
  final int? plays;

  /// When the episode was last watched.
  final DateTime? lastWatchedAt;

  /// When the episode was collected.
  final DateTime? collectedAt;

  /// Optional metadata about the collection state.
  final TraktMediaMetadata? metadata;

  @override
  String toString() {
    return '''TraktEpisodeState{
      number: $number, 
      plays: $plays, 
      lastWatchedAt: $lastWatchedAt, 
      collectedAt: $collectedAt, 
      metadata: $metadata
    }''';
  }
}
