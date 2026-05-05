import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
  );

  final client = TraktApiClient(config: config);

  try {
    print('Fetching trending movies...');
    final response = await client.movies.getTrending(
      limit: 5,
      extended: TraktExtendedInfo.full,
    );
    
    print('Page: ${response.pagination?.currentPage} / ${response.pagination?.pageCount}');
    print('Total items: ${response.pagination?.itemCount}');

    for (var movie in response.data) {
      print('Movie: ${movie.title} (${movie.year})');
      print('Genres: ${movie.genres?.join(', ')}');
      print('Overview: ${movie.overview}');
      print('---');
    }
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
