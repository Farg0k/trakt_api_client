# Trakt API Client for Dart & Flutter

[![pub package](https://img.shields.io/pub/v/trakt_api_client.svg)](https://pub.dev/packages/trakt_api_client)
[![package publisher](https://img.shields.io/pub/publisher/trakt_api_client.svg)](https://pub.dev/packages/trakt_api_client/publisher)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A comprehensive, type-safe, and highly optimized Dart/Flutter client for the [Trakt.tv API](https://trakt.docs.apiary.io/). Designed to provide a premium development experience with advanced features like automated pagination and unified model architecture.

---

## Features

- **🚀 100% API Coverage**: Complete implementation of all Trakt.tv modules including Movies, Shows, Seasons, Episodes, Users, Sync, Search, and more.
- **🛡️ Strict Type Safety**: Full use of Dart enums for all categorical parameters to eliminate runtime errors and ensure IDE autocomplete support.
- **🔐 Pro OAuth2 Management**: Robust authentication with synchronized token refreshing. Parallel requests wait for a single refresh task to avoid race conditions.
- **📄 Smart Pagination System**: Unified `TraktPaginationParams` and the elegant `nextPageParams` helper for effortless sequential data fetching.
- **🏗️ Refined Model Architecture**: Clean, polymorphic models using `TraktMetadata<T>` and standardized ISO 8601 date handling.
- **🔍 Intelligent Search**: Advanced search engine with automatic character escaping and multi-categorical filtering.

---

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  trakt_api_client: ^1.0.0
```

Or install it via terminal:

```bash
dart pub add trakt_api_client
```

---

## Getting Started

### 1. Initialization

Initialize the `TraktApiClient` with your credentials and a callback for token persistence.

```dart
import 'package:trakt_api_client/trakt_api_client.dart';

final client = TraktApiClient(
  config: TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    accessToken: '...', 
    refreshToken: '...',
  ),
  onTokenRefreshed: (token) {
    // Save these new tokens to your secure storage
    print('New Access Token: ${token.accessToken}');
  },
);
```

### Working with OAuth: Single vs Multiple Profiles

The client manages OAuth tokens through `TraktApiClientConfig`. Token refresh happens automatically when a 401 error occurs.

#### Single Profile (Recommended)

For apps that work with one authenticated user:

```dart
final client = TraktApiClient(
  config: TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    accessToken: savedAccessToken,
    refreshToken: savedRefreshToken,
  ),
  onTokenRefreshed: (token) {
    // Called automatically when token is refreshed
    saveTokens(token.accessToken, token.refreshToken);
  },
);

// Use the client - OAuth handled transparently
final myCalendar = await client.calendars.getMyFinales(
  startDate: DateTime.now(),
  days: 7,
);
```

The client stores the current user's tokens. When `getMy*` endpoints return 401, it automatically uses `refreshToken` to get a new token, saves it to config, and retries the request. The `onTokenRefreshed` callback lets you persist the updated tokens.

#### Multiple Profiles

For apps that need to switch between different user accounts:

```dart
final client = TraktApiClient(
  config: TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    accessToken: savedAccessToken,
    refreshToken: savedRefreshToken,
  ),
);
```

Store user tokens externally (e.g., in a map by username):

```dart
Map<String, TraktOAuthToken> userTokens = {};

// Switch to a user's account
Future<void> switchToUser(String username) async {
  final token = userTokens[username];
  if (token == null) throw Exception('User not found');
  
  client.setTokens(
    accessToken: token.accessToken,
    refreshToken: token.refreshToken,
    onTokenRefreshed: (newToken) {
      // Save refreshed token for this specific user
      userTokens[username] = newToken;
      saveUserTokens(username, newToken.accessToken, newToken.refreshToken);
    },
  );
}

// Switch user and fetch their calendar
await switchToUser('user2');
final theirCalendar = await client.calendars.getMyFinales();
```

Each call to `setTokens` replaces the client's tokens and optionally sets a user-specific refresh callback. The callback receives the new token when Trakt returns 401, allowing you to persist per-user tokens.

### 2. Smart Pagination

The library features an advanced pagination system. You can easily fetch subsequent pages using the `nextPageParams` property.

```dart
// Fetch the first page
final trending = await client.movies.getTrending(
  pagination: const TraktPaginationParams(page: 1, limit: 10),
);

// Effortlessly fetch the next page if it exists
if (trending.hasNextPage) {
  final nextPage = await client.movies.getTrending(
    pagination: trending.nextPageParams,
  );
}
```

### 3. Usage Examples

#### Searching with Advanced Filters
```dart
final results = await client.search.textQuery(
  'Spider-man',
  types: [TraktMediaType.movies],
  filters: TraktFilters(
    genres: ['action', 'adventure'],
    years: '2023',
  ),
);
```

#### Synchronized Metadata
All list-based endpoints return metadata-rich items wrapped in `TraktMetadata<T>`.

```dart
final updates = await client.movies.getUpdates(DateTime.now().subtract(const Duration(days: 7)));

for (var metadata in updates.data) {
  print('Updated: ${metadata.item.title} at ${metadata.updatedAt}');
}
```

---

## Architecture & Design

### Silent Refresh & Synchronization
When a `401 Unauthorized` error occurs, the client automatically starts a refresh task. If multiple parallel requests fail simultaneously, they all synchronize and wait for a **single** refresh operation to complete before retrying.

### Unified Generic Models
Redundant wrapper classes have been replaced with a unified `TraktMetadata<T>` system. This ensures a consistent API surface whether you're handling trending items, search results, or collection states.

### Rate Limit Awareness
Track your API usage in real-time via `client.lastRateLimit`. The client handles Trakt's rate limit headers automatically.

---

## Documentation

Every public member is documented with detailed DartDoc comments, including:
- Expected ID formats (Trakt ID, Slug, IMDB).
- Authentication requirements (marked with `🔒 OAuth Required`).
- Comprehensive parameter descriptions and default values.

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for bugs and feature requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
