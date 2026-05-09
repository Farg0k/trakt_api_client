# Trakt API Client for Dart & Flutter

[![pub package](https://img.shields.io/pub/v/trakt_api_client.svg)](https://pub.dev/packages/trakt_api_client)
[![package publisher](https://img.shields.io/pub/publisher/trakt_api_client.svg)](https://pub.dev/packages/trakt_api_client/publisher)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

A comprehensive, type-safe, and highly optimized Dart/Flutter client for the [Trakt.tv API](https://trakt.docs.apiary.io/). Designed to provide a seamless development experience with full coverage of the Trakt ecosystem.

---

## Features

- **🚀 100% API Coverage**: Complete implementation of all Trakt.tv modules including Movies, Shows, Seasons, Episodes, Users, Sync, Search, and more.
- **🛡️ Strict Type Safety**: Full use of Dart enums for all categorical parameters (Sorting, Filtering, Reporting) to eliminate runtime errors.
- **🔐 Advanced Auth Management**: Robust OAuth2 support with automatic silent refresh and state synchronization.
- **🏗️ Refined Model Architecture**: Clean, polymorphic models with standardized ISO 8601 date handling and pagination support.
- **🔍 Smart Search**: Intelligent search engine with automatic character escaping and advanced filtering.
- **⚡ Performance Optimized**: Minimal external dependencies and lightweight manual serialization for maximum speed.

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

Initialize the `TraktApiClient` with your credentials and an optional callback for token persistence.

```dart
import 'package:trakt_api_client/trakt_api_client.dart';

final client = TraktApiClient(
  config: TraktApiClientConfig(
    clientId: 'YOUR_CLIENT_ID',
    clientSecret: 'YOUR_CLIENT_SECRET',
    // Optional: provide existing tokens
    accessToken: '...', 
    refreshToken: '...',
  ),
  onTokenRefreshed: (token) {
    // Automatically called when a token is refreshed.
    // Use this to save tokens to secure storage.
    print('New Access Token: ${token.accessToken}');
  },
);
```

### 2. Authentication (OAuth2)

Trakt uses OAuth2 for authenticated requests. You can handle the authorization flow manually or use the built-in methods.

```dart
// Generate Device Codes for login
final deviceCode = await client.auth.generateDeviceCode();
print('Authorize at: ${deviceCode.verificationUrl}');
print('User Code: ${deviceCode.userCode}');

// Poll for token - updates client state automatically on success
final token = await client.auth.pollForDeviceToken(deviceCode.deviceCode);
```

### 3. Usage Examples

#### Fetching Trending Movies
```dart
final trending = await client.movies.getTrending(
  page: 1,
  limit: 10,
  extended: TraktExtendedInfo.full,
);

for (var entry in trending.data) {
  print('${entry.item.title} has ${entry.watchers} active watchers');
}
```

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

#### Syncing User Collection (Authenticated)
```dart
// [🔒 OAuth Required]
final collection = await client.sync.getCollection<TraktMovie>(
  type: TraktMediaType.movies,
);

for (var entry in collection) {
  print('In Collection: ${entry.item.title}');
}
```

---

## Architecture & Design

### Unified Model System
The library uses a polymorphic approach for media entities. Whether you are searching, fetching trending items, or accessing a user's collection, the data structures remain consistent and intuitive.

### Safe Date Parsing
All date fields are automatically parsed into `DateTime` objects, handling Trakt's specific string formats and ensuring UTC consistency across your application.

### Rate Limit Awareness
The client automatically tracks rate limit headers from Trakt responses, accessible via `client.lastRateLimit`.

---

## Documentation

Every public member is documented with detailed DartDoc comments. You can find:
- Expected ID formats (Trakt ID, Slug, IMDB).
- Authentication requirements (marked with `🔒 OAuth Required`).
- Comprehensive parameter descriptions.

---

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for bugs and feature requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
