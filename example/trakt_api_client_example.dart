import 'package:trakt_api_client/trakt_api_client.dart';

void main() async {
  // 1. Initial Configuration
  final config = TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    // accessToken: '...', // Provide if you already have one
  );

  // 2. Initialize Client
  final client = TraktApiClient(
    config: config,
    onTokenRefreshed: (token) {
      print('Token refreshed automatically: ${token.accessToken}');
      // Save the new token to your persistent storage here
    },
  );

  try {
    // 3. Smart Pagination Example
    print('Fetching trending movies (Page 1)...');
    final trendingMovies = await client.movies.getTrending(
      pagination: const TraktPaginationParams(page: 1, limit: 3),
      extended: TraktExtendedInfo.full,
    );

    print('\nTop Trending Movies:');
    for (var metadata in trendingMovies.data) {
      final movie = metadata.item;
      print('- ${movie.title} (${movie.year})');
      print('  Watchers: ${metadata.watchers}');
      print(
        '  Rating: ${movie.rating?.toStringAsFixed(1)} (${movie.votes} votes)',
      );
    }

    // 4. Automated Next Page Logic
    if (trendingMovies.hasNextPage) {
      print('\n--- Requesting next page using .nextPageParams ---');
      final nextPage = await client.movies.getTrending(
        pagination: trendingMovies.nextPageParams,
        extended: TraktExtendedInfo.full,
      );
      print(
        'Fetched ${nextPage.data.length} more movies for page ${nextPage.pagination?.currentPage}.',
      );
    }

    // 5. Search API with Advanced Filters
    print('\nSearching for Action movies from 2023...');
    final searchResults = await client.search.textQuery(
      'Spider-man',
      types: [TraktMediaType.movies],
      filters: TraktFilters(genres: ['action'], years: '2023'),
      escape: true, // Automatically escape special characters in query
    );

    for (var result in searchResults.data) {
      final movie = result.movie;
      if (movie != null) {
        print(
          '- Found: ${movie.title} (${movie.year}) [TMDB ID: ${movie.ids?.tmdb}]',
        );
      }
    }

    // 6. Authenticated API Example (Commented out as it requires a real token)
    /*
    print('\nFetching user watched history...');
    try {
      final history = await client.users.getHistory(
        'me',
        type: TraktMediaType.movies,
        pagination: const TraktPaginationParams(limit: 5),
      );
      
      for (var entry in history.data) {
        print('Watched ${entry.movie?.title} at ${entry.watchedAt}');
      }
    } on TraktApiException catch (e) {
      if (e.statusCode == 401) {
        print('Authentication required for this call.');
      }
    }
    */
  } on TraktApiException catch (e) {
    print('API Error: ${e.detailedMessage} (Status: ${e.statusCode})');
  } finally {
    // Always close the client to release resources
    client.close();
  }
}
