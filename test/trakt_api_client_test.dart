import 'package:test/test.dart';
import 'package:trakt_api_client/trakt_api_client.dart';

void main() {
  group('TraktApiClientConfig', () {
    test('baseUrl returns staging when useStaging is true', () {
      final config = TraktApiClientConfig(clientId: 'id', useStaging: true);
      expect(config.baseUrl, 'https://api-staging.trakt.tv');
    });

    test('baseUrl returns production by default', () {
      final config = TraktApiClientConfig(clientId: 'id');
      expect(config.baseUrl, 'https://api.trakt.tv');
    });

    test('headers include mandatory trakt headers', () {
      final config = TraktApiClientConfig(clientId: 'my_id');
      final headers = config.headers;

      expect(headers['Content-Type'], 'application/json');
      expect(headers['trakt-api-version'], '2');
      expect(headers['trakt-api-key'], 'my_id');
    });

    test('headers include authorization when token is present', () {
      final config = TraktApiClientConfig(clientId: 'id', accessToken: 'token');
      expect(config.headers['Authorization'], 'Bearer token');
    });

    test('headers include custom headers', () {
      final config = TraktApiClientConfig(
        clientId: 'id',
        customHeaders: {'X-Custom': 'value'},
      );
      expect(config.headers['X-Custom'], 'value');
    });
  });

  group('TraktApiException', () {
    test('toString includes message and status code', () {
      const ex = TraktApiException('Error', statusCode: 404);
      expect(ex.toString(), contains('Error'));
      expect(ex.toString(), contains('404'));
    });

    test('toString includes rate limit info', () {
      const rateLimit = TraktRateLimit(limit: 100, remaining: 50);
      const ex = TraktApiException('Rate limited', rateLimit: rateLimit);
      expect(ex.toString(), contains('Rate Limit'));
    });
  });
}
