# Trakt.tv API Client for Dart & Flutter

A comprehensive, type-safe, and highly optimized Dart/Flutter client for the [Trakt.tv API](https://trakt.docs.apiary.io/). Designed to be consistent, robust, and developer-friendly.

## Features

- **100% API Coverage**: Implementation of all documented Trakt endpoints (Movies, Shows, Seasons, Episodes, Users, Sync, Search, Checkin, Scrobble, etc.).
- **Strict Type Safety**: Extensive use of Enums for all categorical parameters (Sorting, Reporting, Privacy, Media Types, Extended Info) to prevent runtime errors.
- **Advanced Auth Management**:
  - Full OAuth2 support (Authorization Code and Device flows).
  - **Silent Refresh**: Automatic token refreshing with a built-in retry mechanism.
  - **State Sync**: The client automatically updates its internal configuration upon successful authentication or refresh.
- **Refined Model Architecture**:
  - **Polymorphic Entities**: Unified `TraktMediaEntity` for search results and list items.
  - **Generic Wrappers**: Clean data access using structures like `TraktTrending<T>` or `TraktMediaState<T>`.
  - **Robust Parsing**: Safe `DateTime` parsing and standardized ISO 8601 UTC compliance.
- **Smart Search**: Automatic escaping of special characters for the Trakt search engine.
- **Rate Limit Aware**: Built-in tracking of Trakt rate limit headers.
- **Zero External Code Gen**: Manual JSON serialization to keep the package lightweight and fast.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  trakt_api_client: ^1.0.0
```

## Getting Started

### 1. Initialization

```dart
import 'package:trakt_api_client/trakt_api_client.dart';

final client = TraktApiClient(
  config: TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    // Optional initial tokens
    accessToken: '...', 
    refreshToken: '...',
  ),
  onTokenRefreshed: (token) {
    // Automatically called when a token is refreshed or acquired.
    // Save these to your secure storage.
    print('New Access Token: ${token.accessToken}');
  },
);
```

### 2. Authentication (Device Flow)

```dart
// 1. Generate codes
final deviceCode = await client.auth.generateDeviceCode();
print('Authorize at: ${deviceCode.verificationUrl}');
print('Code: ${deviceCode.userCode}');

// 2. Poll for token
// The client will automatically update its config and trigger onTokenRefreshed upon success.
final token = await client.auth.pollForDeviceToken(deviceCode.deviceCode);
```

### 3. Fetching Data

```dart
// Get Trending Movies with stats and full metadata
final trending = await client.movies.getTrending(
  page: 1,
  limit: 10,
  extended: TraktExtendedInfo.full,
);

for (var entry in trending.data) {
  print('${entry.item.title} - ${entry.watchers} people watching');
}
```

### 4. Searching with Filters

```dart
final results = await client.search.textQuery(
  'Spider-man',
  types: [TraktMediaType.movies],
  filters: TraktFilters(
    genres: ['action', 'adventure'],
    years: '2021-2024',
  ),
  escape: true, // Auto-escape special characters like ":" or "-"
);
```

### 5. Syncing (Authenticated)

```dart
// [🔒 OAuth Required] - Requires valid accessToken in config
final watched = await client.sync.getWatched<TraktMovie>(
  type: TraktMediaType.movies,
);

for (var state in watched) {
  print('Watched: ${state.item.title} (Plays: ${state.plays})');
}
```

## Image Handling

**Important Note**: Consistent with Trakt.tv's API design, this package **does not return direct image URLs**. Trakt provides stable IDs (TMDB, TVDB, IMDB). 

To display images, you should use the IDs provided in our models (e.g., `movie.ids.tmdb`) in conjunction with a specialized image provider or another API client like `tmdb_api`.

## Documentation

Every method and model is documented using DartDoc. Simply hover over a method in your IDE to see:
- Valid ID formats (Trakt ID, Slug, IMDB).
- Authentication requirements (marked with `🔒 OAuth Required`).
- Descriptions of parameters and return types.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
