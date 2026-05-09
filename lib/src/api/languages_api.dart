import '../core/trakt_api_client.dart';
import '../core/trakt_media_class.dart';
import '../models/trakt_media_models.dart';

/// Access to language endpoints.
class LanguagesApi {
  /// Creates a new [LanguagesApi] instance.
  LanguagesApi(this._client);

  /// Internal client reference.
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
