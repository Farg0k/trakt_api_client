import '../core/trakt_api_client.dart';
import '../core/trakt_media_class.dart';
import '../models/trakt_media_models.dart';

/// Access to genre endpoints.
class GenresApi {
  /// Creates a new [GenresApi] instance.
  GenresApi(this._client);

  /// Internal client reference.
  final TraktApiClient _client;

  /// Get all genres for movies or shows.
  Future<List<TraktGenre>> getGenres(TraktMediaClass type) async {
    return _client.get(
      '/genres/${type.value}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktGenre.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
