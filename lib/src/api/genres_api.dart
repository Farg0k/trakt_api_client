import '../core/trakt_api_client.dart';
import '../models/trakt_genre.dart';

class GenresApi {
  final TraktApiClient _client;

  GenresApi(this._client);

  /// Get a list of all genres for movies.
  Future<List<TraktGenre>> getMovies() async {
    return _getGenres('/genres/movies');
  }

  /// Get a list of all genres for shows.
  Future<List<TraktGenre>> getShows() async {
    return _getGenres('/genres/shows');
  }

  Future<List<TraktGenre>> _getGenres(String path) async {
    return _client.get(
      path,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktGenre.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
