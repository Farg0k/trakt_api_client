import '../core/trakt_date_utils.dart';

/// Generic model for user's watched/collected items.
class TraktMediaState<T> {
  const TraktMediaState({
    this.plays,
    this.lastWatchedAt,
    this.lastCollectedAt,
    required this.lastUpdatedAt,
    required this.item,
    this.seasons,
    this.metadata,
  });

  factory TraktMediaState.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
    String itemKey,
  ) {
    return TraktMediaState(
      plays: json['plays'] as int?,
      lastWatchedAt: TraktDateUtils.parse(json['last_watched_at']),
      lastCollectedAt: TraktDateUtils.parse(json['last_collected_at']),
      lastUpdatedAt:
          TraktDateUtils.parse(json['last_updated_at']) ?? DateTime.now(),
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
      metadata: json['metadata'] as Map<String, dynamic>?,
      seasons: json['seasons'] != null
          ? (json['seasons'] as List)
                .map(
                  (e) => TraktSeasonState.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }
  final int? plays;
  final DateTime? lastWatchedAt;
  final DateTime? lastCollectedAt;
  final DateTime lastUpdatedAt;
  final T item;
  final List<TraktSeasonState>? seasons;
  final Map<String, dynamic>? metadata;
}

class TraktSeasonState {
  const TraktSeasonState({required this.number, required this.episodes});

  factory TraktSeasonState.fromJson(Map<String, dynamic> json) {
    return TraktSeasonState(
      number: json['number'] as int? ?? 0,
      episodes: (json['episodes'] as List? ?? [])
          .map((e) => TraktEpisodeState.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final int number;
  final List<TraktEpisodeState> episodes;
}

class TraktEpisodeState {
  const TraktEpisodeState({
    required this.number,
    this.plays,
    this.lastWatchedAt,
    this.collectedAt,
    this.metadata,
  });

  factory TraktEpisodeState.fromJson(Map<String, dynamic> json) {
    return TraktEpisodeState(
      number: json['number'] as int? ?? 0,
      plays: json['plays'] as int?,
      lastWatchedAt: TraktDateUtils.parse(json['last_watched_at']),
      collectedAt: TraktDateUtils.parse(json['collected_at']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
  final int number;
  final int? plays;
  final DateTime? lastWatchedAt;
  final DateTime? collectedAt;
  final Map<String, dynamic>? metadata;
}
