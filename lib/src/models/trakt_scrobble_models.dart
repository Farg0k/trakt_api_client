import 'trakt_movie.dart';
import 'trakt_episode.dart';
import 'trakt_sharing.dart';

/// Response to a scrobble request.
class TraktScrobbleResponse {

  /// Creates a new [TraktScrobbleResponse] instance.
  const TraktScrobbleResponse({
    required this.id,
    required this.progress,
    this.sharing,
    this.movie,
    this.episode,
    required this.type,
  });

  /// Creates a [TraktScrobbleResponse] from a JSON map.
  factory TraktScrobbleResponse.fromJson(Map<String, dynamic> json) {
    return TraktScrobbleResponse(
      id: json['id'] as int? ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      sharing: json['sharing'] != null
          ? TraktSharing.fromJson(json['sharing'] as Map<String, dynamic>)
          : null,
      movie: json['movie'] != null
          ? TraktMovie.fromJson(json['movie'] as Map<String, dynamic>)
          : null,
      episode: json['episode'] != null
          ? TraktEpisode.fromJson(json['episode'] as Map<String, dynamic>)
          : null,
      type: json['type'] as String? ?? '',
    );
  }
  /// Unique ID of the scrobble session.
  final int id;
  /// Progress percentage (0-100).
  final double progress;
  /// Sharing settings used.
  final TraktSharing? sharing;
  /// The movie object, if scrobbling a movie.
  final TraktMovie? movie;
  /// The episode object, if scrobbling an episode.
  final TraktEpisode? episode;
  /// Type of the media item.
  final String type;

  @override
  String toString() {
    return '''TraktScrobbleResponse{
      id: $id, 
      progress: $progress, 
      sharing: $sharing, 
      movie: $movie, 
      episode: $episode, 
      type: $type
    }''';
  }
}
