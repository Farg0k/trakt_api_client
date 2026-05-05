import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    userAgent: 'MyTraktApp/1.0.0',
  );

  final client = TraktApiClient(
    config: config,
    onRateLimitChanged: (limit) {
      print('Rate Limit Updated: ${limit.remaining} remaining');
    },
  );

  try {
    // 1. Device Authentication Flow
    print('Step 1: Generating Device Code...');
    final deviceCode = await client.auth.generateDeviceCode();
    
    print('Please visit: ${deviceCode.verificationUrl}');
    print('And enter code: ${deviceCode.userCode}');
    print('Waiting for authorization (polling every ${deviceCode.interval}s)...');

    TraktOAuthToken? token;
    while (token == null) {
      await Future.delayed(Duration(seconds: deviceCode.interval));
      
      try {
        token = await client.auth.pollForDeviceToken(deviceCode.deviceCode);
      } catch (e) {
        if (e is TraktApiException) {
          if (e.statusCode == 400) {
            print('Still waiting for user to authorize...');
            continue;
          } else if (e.statusCode == 418) {
            print('User denied access.');
            break;
          } else if (e.statusCode == 410) {
            print('Code expired. Please restart the process.');
            break;
          }
        }
        rethrow;
      }
    }

    if (token != null) {
      print('Authorization Successful!');
      print('Access Token: ${token.accessToken}');

      // 2. Fetching Data with Pagination and Filters
      print('\nStep 2: Fetching Trending Movies...');
      final response = await client.movies.getTrending(
        limit: 5,
        extended: TraktExtendedInfo.full,
        filters: const TraktFilters(years: '2020-2024'),
      );
      
      print('Page: ${response.pagination?.currentPage} / ${response.pagination?.pageCount}');

      for (var movie in response.data) {
        print(' - ${movie.title} (${movie.year}) [Rating: ${movie.rating}]');
      }
    }

  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
