import '../core/trakt_date_utils.dart';

/// Generic wrapper for trending items.
class TraktTrending<T> {

  /// Creates a new [TraktTrending] instance.
  const TraktTrending({required this.watchers, required this.item});

  /// Creates a [TraktTrending] from a JSON map.
  factory TraktTrending.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktTrending(
      watchers: json['watchers'] as int? ?? 0,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// Number of users watching this item.
  final int watchers;
  /// The media item.
  final T item;
}

/// Generic wrapper for most played/watched/collected items.
class TraktMost<T> {

  /// Creates a new [TraktMost] instance.
  const TraktMost({
    this.watcherCount,
    this.playCount,
    this.collectedCount,
    this.userCount,
    required this.item,
  });

  /// Creates a [TraktMost] from a JSON map.
  factory TraktMost.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktMost(
      watcherCount: json['watcher_count'] as int?,
      playCount: json['play_count'] as int?,
      collectedCount: json['collected_count'] as int?,
      userCount: json['user_count'] as int?,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// Number of watchers.
  final int? watcherCount;
  /// Total play count.
  final int? playCount;
  /// Number of times collected.
  final int? collectedCount;
  /// Number of users.
  final int? userCount;
  /// The media item.
  final T item;
}

/// Generic wrapper for anticipated items.
class TraktAnticipated<T> {

  /// Creates a new [TraktAnticipated] instance.
  const TraktAnticipated({required this.listCount, required this.item});

  /// Creates a [TraktAnticipated] from a JSON map.
  factory TraktAnticipated.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktAnticipated(
      listCount: json['list_count'] as int? ?? 0,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// Number of lists containing this item.
  final int listCount;
  /// The media item.
  final T item;
}

/// Generic wrapper for favorited items.
class TraktFavorited<T> {

  /// Creates a new [TraktFavorited] instance.
  const TraktFavorited({required this.userCount, required this.item});

  /// Creates a [TraktFavorited] from a JSON map.
  factory TraktFavorited.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktFavorited(
      userCount: json['user_count'] as int? ?? 0,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// Number of users who favorited this item.
  final int userCount;
  /// The media item.
  final T item;
}

/// Generic wrapper for updated items.
class TraktUpdate<T> {

  /// Creates a new [TraktUpdate] instance.
  const TraktUpdate({required this.updatedAt, required this.item});

  /// Creates a [TraktUpdate] from a JSON map.
  factory TraktUpdate.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktUpdate(
      updatedAt: TraktDateUtils.parse(json['updated_at']) ?? DateTime.now(),
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// When the item was updated.
  final DateTime updatedAt;
  /// The media item.
  final T item;
}

/// Generic wrapper for deleted items.
class TraktDeleted<T> {

  /// Creates a new [TraktDeleted] instance.
  const TraktDeleted({required this.deletedAt, required this.item});

  /// Creates a [TraktDeleted] from a JSON map.
  factory TraktDeleted.fromJson(Map<String, dynamic> json,
      T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktDeleted(
      deletedAt: TraktDateUtils.parse(json['deleted_at']) ?? DateTime.now(),
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
  /// When the item was deleted.
  final DateTime deletedAt;
  /// The media item.
  final T item;
}
