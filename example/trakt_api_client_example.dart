import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
  );

  final client = TraktApiClient(config: config);

  try {
    print('Fetching trending movies...');
    final trending = await client.movies.getTrending(limit: 5);
    
    for (var movie in trending) {
      print('Movie: ${movie.title} (${movie.year})');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
