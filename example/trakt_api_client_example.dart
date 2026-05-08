import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  // 1. Initial Configuration
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    // Optional: provide existing token if you have one
    // accessToken: '...',
    // refreshToken: '...',
  );

  // 2. Initialize Client
  final client = TraktApiClient(
    config: config,
    onTokenRefreshed: (token) {
      print('Token refreshed automatically!');
      // Save token.accessToken to your storage
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
      print('  Overview: ${movie.overview?.substring(0, 100)}...');
    }

    print('\nPagination Info:');
    print('Current Page: ${trendingMovies.pagination?.currentPage}');
    print('Total Pages: ${trendingMovies.pagination?.pageCount}');

    // 4. Device Authentication Flow Example
    /*
    print('\nStarting Device Auth Flow...');
    final deviceCode = await client.auth.generateDeviceCode();
    print('Please go to: ${deviceCode.verificationUrl}');
    print('And enter code: ${deviceCode.userCode}');

    // Polling for token (usually you'd do this in a loop with delay)
    // The library handles automatic update of client.config upon success!
    // final token = await client.auth.pollForDeviceToken(deviceCode.deviceCode);
    */

    // 5. Authenticated API Example: Get My Watchlist
    // (Requires actual token in config)
    /*
    if (client.config.accessToken != null) {
      print('\nFetching your watchlist...');
      final watchlist = await client.sync.getWatchlist(
        type: TraktMediaType.movies,
        sort: TraktWatchlistSort.added,
      );
      
      for (var result in watchlist.data) {
        print('- ${result.movie?.title}');
      }
    }
    */

    // 6. Advanced: Using Filters
    print('\nSearching for Action movies from 2023...');
    final actionMovies = await client.search.textQuery(
      'Spiderman',
      types: [TraktMediaType.movies],
      filters: TraktFilters(
        genres: ['action'],
        years: '2023',
      ),
      escape: true, // Automatically escape special characters
    );

    for (var result in actionMovies.data) {
      print('- Found: ${result.movie?.title} (${result.movie?.year})');
    }

  } on TraktApiException catch (e) {
    print('API Error: ${e.message} (Status: ${e.statusCode})');
  } finally {
    client.close();
  }
}
