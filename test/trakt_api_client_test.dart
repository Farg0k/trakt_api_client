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
      expect(config.headers['Content-Type'], 'application/json');
    });

    test('headers should include User-Agent if provided', () {
      final config = TraktApiClientConfig(
        clientId: 'id',
        userAgent: 'MyAppName/1.0.0',
      );
      expect(config.headers['User-Agent'], 'MyAppName/1.0.0');
    });

    test('headers should include custom headers', () {
      final config = TraktApiClientConfig(
        clientId: 'id',
        customHeaders: {'X-Custom-Header': 'custom_value'},
      );
      expect(config.headers['X-Custom-Header'], 'custom_value');
      expect(config.headers['trakt-api-key'], 'id');
    });

    test('custom headers should be able to override default headers', () {
      final config = TraktApiClientConfig(
        clientId: 'id',
        customHeaders: {'trakt-api-version': '3'},
      );
      expect(config.headers['trakt-api-version'], '3');
    });
  });
}
