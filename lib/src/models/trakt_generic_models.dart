import '../core/trakt_date_utils.dart';

/// Generic wrapper for trending items.
class TraktTrending<T> {
  final int watchers;
  final T item;

  const TraktTrending({required this.watchers, required this.item});

  factory TraktTrending.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktTrending(
      watchers: json['watchers'] as int? ?? 0,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}

/// Generic wrapper for most played/watched/collected items.
class TraktMost<T> {
  final int? watcherCount;
  final int? playCount;
  final int? collectedCount;
  final int? userCount;
  final T item;

  const TraktMost({
    this.watcherCount,
    this.playCount,
    this.collectedCount,
    this.userCount,
    required this.item,
  });

  factory TraktMost.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktMost(
      watcherCount: json['watcher_count'] as int?,
      playCount: json['play_count'] as int?,
      collectedCount: json['collected_count'] as int?,
      userCount: json['user_count'] as int?,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}

/// Generic wrapper for anticipated items.
class TraktAnticipated<T> {
  final int listCount;
  final T item;

  const TraktAnticipated({required this.listCount, required this.item});

  factory TraktAnticipated.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktAnticipated(
      listCount: json['list_count'] as int? ?? 0,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}

/// Generic wrapper for favorited items.
class TraktFavorited<T> {
  final int userCount;
  final T item;

  const TraktFavorited({required this.userCount, required this.item});

  factory TraktFavorited.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktFavorited(
      userCount: json['user_count'] as int? ?? 0,
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}

/// Generic wrapper for updated items.
class TraktUpdate<T> {
  final DateTime updatedAt;
  final T item;

  const TraktUpdate({required this.updatedAt, required this.item});

  factory TraktUpdate.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktUpdate(
      updatedAt: TraktDateUtils.parse(json['updated_at']) ?? DateTime.now(),
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}

/// Generic wrapper for deleted items.
class TraktDeleted<T> {
  final DateTime deletedAt;
  final T item;

  const TraktDeleted({required this.deletedAt, required this.item});

  factory TraktDeleted.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT, String itemKey) {
    return TraktDeleted(
      deletedAt: TraktDateUtils.parse(json['deleted_at']) ?? DateTime.now(),
      item: fromJsonT(json[itemKey] as Map<String, dynamic>),
    );
  }
}
