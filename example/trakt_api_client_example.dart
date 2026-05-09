import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  // 1. Initial Configuration
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
  );

  // 2. Initialize Client
  final client = TraktApiClient(
    config: config,
    onTokenRefreshed: (token) {
      print('Token refreshed automatically!');
    },
  );

  try {
    // 3. Public API Example: Get Trending Movies (Paginated)
    print('Fetching trending movies...');
    final trendingMovies = await client.movies.getTrending(
      page: 1,
      limit: 5,
      extended: TraktExtendedInfo.full,
    );

    print('Top Trending Movies:');
    for (var trending in trendingMovies.data) {
      final movie = trending.item;
      print('- ${movie.title} (${movie.year}) - Watchers: ${trending.watchers}');
    }

    // 4. Advanced: Using Filters
    print('\nSearching for Action movies from 2023...');
    final actionMovies = await client.search.textQuery(
      'Spiderman',
      types: [TraktMediaType.movies],
      filters: TraktFilters(
        genres: ['action'],
        years: '2023',
      ),
      escape: true,
    );

    for (var result in actionMovies.data) {
      final movie = result.movie;
      if (movie != null) {
        print('- Found: ${movie.title} (${movie.year})');
      }
    }

  } on TraktApiException catch (e) {
    print('API Error: ${e.message} (Status: ${e.statusCode})');
  } finally {
    client.close();
  }
}
