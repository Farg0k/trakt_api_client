import '../core/trakt_date_utils.dart';

/// Generic wrapper for metadata-heavy items (Trending, Most Played, etc.).
class TraktMetadata<T> {
  /// Creates a new [TraktMetadata] instance.
  const TraktMetadata({
    required this.item,
    this.watchers,
    this.watcherCount,
    this.playCount,
    this.collectedCount,
    this.userCount,
    this.listCount,
    this.updatedAt,
    this.deletedAt,
  });

  /// Creates a [TraktMetadata] from a JSON map.
  factory TraktMetadata.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktMetadata(
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
      watchers: json['watchers'] as int?,
      watcherCount: json['watcher_count'] as int?,
      playCount: json['play_count'] as int?,
      collectedCount: json['collected_count'] as int?,
      userCount: json['user_count'] as int?,
      listCount: json['list_count'] as int?,
      updatedAt: TraktDateUtils.parse(json['updated_at']),
      deletedAt: TraktDateUtils.parse(json['deleted_at']),
    );
  }

  /// The media item.
  final T item;

  /// Number of users watching this item (Trending).
  final int? watchers;

  /// Number of watchers (Most Played/Watched).
  final int? watcherCount;

  /// Total play count.
  final int? playCount;

  /// Number of times collected.
  final int? collectedCount;

  /// Number of users (Most Favorited).
  final int? userCount;

  /// Number of lists containing this item (Anticipated).
  final int? listCount;

  /// When the item was updated.
  final DateTime? updatedAt;

  /// When the item was deleted.
  final DateTime? deletedAt;

  @override
  String toString() {
    return '''TraktMetadata{
      item: $item, 
      watchers: $watchers, 
      watcherCount: $watcherCount, 
      playCount: $playCount, 
      collectedCount: $collectedCount, 
      userCount: $userCount, 
      listCount: $listCount, 
      updatedAt: $updatedAt, 
      deletedAt: $deletedAt
    }''';
  }
}

/// Generic wrapper for calendar entries.
class TraktCalendarEntry<T> {
  /// Creates a new [TraktCalendarEntry] instance.
  const TraktCalendarEntry({
    required this.date,
    required this.item,
    this.show,
  });

  /// Creates a [TraktCalendarEntry] from a JSON map.
  factory TraktCalendarEntry.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
    String dateKey, {
    String? itemKey,
    dynamic showJson,
    T Function(Map<String, dynamic>)? showMapper,
  }) {
    final itemData = itemKey != null
        ? json[itemKey] as Map<String, dynamic>
        : json;
    
    return TraktCalendarEntry(
      date: TraktDateUtils.parse(json[dateKey]) ?? DateTime.now(),
      item: fromJsonT(itemData),
      show: showJson != null && showMapper != null ? showMapper(showJson) : null,
    );
  }

  /// The air or release date.
  final DateTime date;

  /// The media item (Movie or Episode).
  final T item;

  /// The show (for episodes in calendar).
  final dynamic show;

  @override
  String toString() {
    return '''TraktCalendarEntry{
      date: $date, 
      item: $item, 
      show: $show
    }''';
  }
}
