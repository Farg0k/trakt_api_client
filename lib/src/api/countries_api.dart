import '../core/trakt_api_client.dart';
import '../models/trakt_country.dart';

class CountriesApi {
  final TraktApiClient _client;

  CountriesApi(this._client);

  /// Get a list of all countries for movies.
  Future<List<TraktCountry>> getMovies() async {
    return _getCountries('/countries/movies');
  }

  /// Get a list of all countries for shows.
  Future<List<TraktCountry>> getShows() async {
    return _getCountries('/countries/shows');
  }

  Future<List<TraktCountry>> _getCountries(String path) async {
    return _client.get(
      path,
      mapper: (body, headers) => (body as List)
          .map((item) => TraktCountry.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
