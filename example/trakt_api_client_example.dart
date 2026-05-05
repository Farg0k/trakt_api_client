import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
  );

  final client = TraktApiClient(config: config);

  try {
    print('Fetching trending movies...');
    final response = await client.movies.getTrending(limit: 5);
    
    print('Page: ${response.pagination?.currentPage} / ${response.pagination?.pageCount}');
    print('Total items: ${response.pagination?.itemCount}');

    for (var movie in response.data) {
      print('Movie: ${movie.title} (${movie.year})');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
