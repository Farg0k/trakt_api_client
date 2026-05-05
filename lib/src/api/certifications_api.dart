import '../core/trakt_api_client.dart';
import '../models/trakt_certification.dart';

class CertificationsApi {
  final TraktApiClient _client;

  CertificationsApi(this._client);

  /// Get movie certifications for all countries.
  ///
  /// Returns a map where keys are country codes (e.g., 'us') and values are
  /// lists of [TraktCertification].
  Future<Map<String, List<TraktCertification>>> getMovies() async {
    return _getCertifications('/certifications/movies');
  }

  /// Get show certifications for all countries.
  ///
  /// Returns a map where keys are country codes (e.g., 'us') and values are
  /// lists of [TraktCertification].
  Future<Map<String, List<TraktCertification>>> getShows() async {
    return _getCertifications('/certifications/shows');
  }

  Future<Map<String, List<TraktCertification>>> _getCertifications(String path) async {
    return _client.get(
      path,
      mapper: (body, headers) {
        final Map<String, dynamic> jsonMap = body as Map<String, dynamic>;
        return jsonMap.map((country, list) {
          final certList = (list as List)
              .map((item) => TraktCertification.fromJson(item as Map<String, dynamic>))
              .toList();
          return MapEntry(country, certList);
        });
      },
    );
  }
}
