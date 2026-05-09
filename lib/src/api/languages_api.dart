import '../core/trakt_api_client.dart';
import '../core/trakt_media_class.dart';
import '../models/trakt_media_models.dart';

class LanguagesApi {
  LanguagesApi(this._client);
  final TraktApiClient _client;

  /// Get all languages for movies or shows.
  Future<List<TraktLanguage>> getLanguages(TraktMediaClass type) async {
    return _client.get(
      '/languages/${type.value}',
      mapper: (body, headers) => (body as List)
          .map((item) => TraktLanguage.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
