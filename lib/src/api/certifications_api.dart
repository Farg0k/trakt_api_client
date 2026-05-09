import '../core/trakt_api_client.dart';
import '../core/trakt_media_class.dart';
import '../models/trakt_media_models.dart';

/// Access to certification endpoints.
class CertificationsApi {

  /// Creates a new [CertificationsApi] instance.
  CertificationsApi(this._client);
  /// Internal client reference.
  final TraktApiClient _client;


  /// Get all certifications for movies or shows.
  Future<List<TraktCertification>> getCertifications(
      TraktMediaClass type) async {
    return _client.get(
      '/certifications/${type.value}',
      mapper: (body, headers) {
        final Map<String, dynamic> json = body as Map<String, dynamic>;
        return (json['us'] as List)
            .map((item) =>
                TraktCertification.fromJson(item as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
