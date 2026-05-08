import '../core/trakt_api_client.dart';
import '../core/trakt_media_class.dart';
import '../models/trakt_country.dart';

class CountriesApi {
  final TraktApiClient _client;

  CountriesApi(this._client);

  /// Get all countries for movies or shows.
  Future<List<TraktCountry>> getCountries(TraktMediaClass type) async {
    return _client.get(
      '/countries/${type.value}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktCountry.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
