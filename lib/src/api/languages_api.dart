import '../core/trakt_api_client.dart';
import '../models/trakt_language.dart';

class LanguagesApi {
  final TraktApiClient _client;

  LanguagesApi(this._client);

  /// Get a list of all languages for movies.
  Future<List<TraktLanguage>> getMovies() async {
    return _getLanguages('/languages/movies');
  }

  /// Get a list of all languages for shows.
  Future<List<TraktLanguage>> getShows() async {
    return _getLanguages('/languages/shows');
  }

  Future<List<TraktLanguage>> _getLanguages(String path) async {
    return _client.get(
      path,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktLanguage.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
