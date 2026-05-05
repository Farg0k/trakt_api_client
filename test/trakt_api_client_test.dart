import 'package:test/test.dart';
import 'package:trakt_api_client/trakt_api_client.dart';

void main() {
  group('TraktApiClientConfig', () {
    test('baseUrl should be staging when useStaging is true', () {
      final config = TraktApiClientConfig(clientId: 'id', useStaging: true);
      expect(config.baseUrl, 'https://api-staging.trakt.tv');
    });

    test('baseUrl should be production by default', () {
      final config = TraktApiClientConfig(clientId: 'id');
      expect(config.baseUrl, 'https://api.trakt.tv');
    });

    test('headers should include client id', () {
      final config = TraktApiClientConfig(clientId: 'my_id');
      expect(config.headers['trakt-api-key'], 'my_id');
      expect(config.headers['trakt-api-version'], '2');
    });
  });
}
