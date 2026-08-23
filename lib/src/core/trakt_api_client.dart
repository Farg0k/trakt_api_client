import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/authentication_api.dart';
import '../api/calendars_api.dart';
import '../api/certifications_api.dart';
import '../api/checkin_api.dart';
import '../api/comments_api.dart';
import '../api/countries_api.dart';
import '../api/episodes_api.dart';
import '../api/genres_api.dart';
import '../api/languages_api.dart';
import '../api/lists_api.dart';
import '../api/movies_api.dart';
import '../api/networks_api.dart';
import '../api/notes_api.dart';
import '../api/people_api.dart';
import '../api/recommendations_api.dart';
import '../api/scrobble_api.dart';
import '../api/search_api.dart';
import '../api/seasons_api.dart';
import '../api/shows_api.dart';
import '../api/sync_api.dart';
import '../api/users_api.dart';
import 'trakt_api_config.dart';
import 'trakt_api_exception.dart';
import 'trakt_rate_limit.dart';
import 'trakt_list_response.dart';
import 'trakt_pagination_params.dart';
import '../models/trakt_auth_models.dart';

/// The main entry point for the Trakt.tv API.
///
/// This client provides access to all Trakt API modules.
class TraktApiClient {
  /// Creates a new Trakt API client.
  TraktApiClient({
    required this.config,
    this.onTokenRefreshed,
    this.onTokenRefreshFailed,
    http.Client? httpClient,
  }) : _client = httpClient ?? http.Client();

  /// The configuration for this client.
  TraktApiClientConfig config;

  /// Callback triggered when an OAuth token is refreshed.
  void Function(TraktOAuthToken token)? onTokenRefreshed;

  /// Callback triggered when an OAuth token refresh fails.
  void Function(TraktApiException error)? onTokenRefreshFailed;

  final http.Client _client;
  Future<void>? _refreshTask;
  TraktRateLimit? _lastRateLimit;

  /// Access to authentication endpoints.
  AuthenticationApi get authentication => AuthenticationApi(this);

  /// Updates the OAuth tokens used for authenticated requests.
  void setTokens({
    required String accessToken,
    String? refreshToken,
    void Function(TraktOAuthToken token)? onTokenRefreshed,
    void Function(TraktApiException error)? onTokenRefreshFailed,
  }) {
    config = config.copyWith(
      accessToken: accessToken,
      refreshToken: refreshToken ?? config.refreshToken,
    );
    if (onTokenRefreshed != null) {
      this.onTokenRefreshed = onTokenRefreshed;
    }
    if (onTokenRefreshFailed != null) {
      this.onTokenRefreshFailed = onTokenRefreshFailed;
    }
  }

  /// Access to calendar endpoints.
  CalendarsApi get calendars => CalendarsApi(this);

  /// Access to certification endpoints.
  CertificationsApi get certifications => CertificationsApi(this);

  /// Access to checkin endpoints.
  CheckinApi get checkin => CheckinApi(this);

  /// Access to comment endpoints.
  CommentsApi get comments => CommentsApi(this);

  /// Access to country endpoints.
  CountriesApi get countries => CountriesApi(this);

  /// Access to episode endpoints.
  EpisodesApi get episodes => EpisodesApi(this);

  /// Access to genre endpoints.
  GenresApi get genres => GenresApi(this);

  /// Access to language endpoints.
  LanguagesApi get languages => LanguagesApi(this);

  /// Access to list endpoints.
  ListsApi get lists => ListsApi(this);

  /// Access to movie endpoints.
  MoviesApi get movies => MoviesApi(this);

  /// Access to network endpoints.
  NetworksApi get networks => NetworksApi(this);

  /// Access to note endpoints.
  NotesApi get notes => NotesApi(this);

  /// Access to people endpoints.
  PeopleApi get people => PeopleApi(this);

  /// Access to recommendation endpoints.
  RecommendationsApi get recommendations => RecommendationsApi(this);

  /// Access to scrobble endpoints.
  ScrobbleApi get scrobble => ScrobbleApi(this);

  /// Access to search endpoints.
  SearchApi get search => SearchApi(this);

  /// Access to season endpoints.
  SeasonsApi get seasons => SeasonsApi(this);

  /// Access to show endpoints.
  ShowsApi get shows => ShowsApi(this);

  /// Access to sync endpoints.
  SyncApi get sync => SyncApi(this);

  /// Access to user endpoints.
  UsersApi get users => UsersApi(this);

  /// Returns the rate limit information from the last request.
  TraktRateLimit? get lastRateLimit => _lastRateLimit;

  /// Performs a GET request that returns a list with pagination.
  Future<TraktListResponse<T>> getList<T>(
    String path, {
    Map<String, String>? queryParams,
    TraktPaginationParams? pagination,
    bool authenticated = false,
    required T Function(Map<String, dynamic> json) mapper,
  }) async {
    final effectiveQueryParams = <String, String>{};
    if (queryParams != null) effectiveQueryParams.addAll(queryParams);
    if (pagination != null) {
      effectiveQueryParams.addAll(pagination.toQueryParams());
    }

    return get(
      path,
      queryParams: effectiveQueryParams.isEmpty ? null : effectiveQueryParams,
      authenticated: authenticated,
      mapper: (body, headers) {
        if (body == null) {
          return TraktListResponse(
            data: [],
            pagination: TraktPagination.fromHeaders(headers),
            requestParams: pagination,
          );
        }

        final List<dynamic> list;
        if (body is List) {
          list = body;
        } else if (body is Map<String, dynamic>) {
          list = [body];
        } else {
          // Unexpected type, return empty list
          list = [];
        }

        final data = list
            .where((item) => item != null && item is Map<String, dynamic>)
            .map((item) => item as Map<String, dynamic>)
            .map(mapper)
            .toList();
        return TraktListResponse(
          data: data,
          pagination: TraktPagination.fromHeaders(headers),
          requestParams: pagination,
        );
      },
    );
  }

  /// Performs a GET request.
  Future<T> get<T>(
    String path, {
    Map<String, String>? queryParams,
    bool authenticated = false,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      (headers) => _client.get(
        Uri.parse(
          '${config.baseUrl}$path',
        ).replace(queryParameters: queryParams),
        headers: headers,
      ),
      mapper,
      authenticated: authenticated,
    );
  }

  /// Performs a POST request.
  Future<T> post<T>(
    String path, {
    dynamic body,
    bool authenticated = false,
    String? baseUrlOverride,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      (headers) => _client.post(
        Uri.parse('${baseUrlOverride ?? config.baseUrl}$path'),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
      mapper,
      authenticated: authenticated,
    );
  }

  /// Performs a PUT request.
  Future<T> put<T>(
    String path, {
    dynamic body,
    bool authenticated = false,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      (headers) => _client.put(
        Uri.parse('${config.baseUrl}$path'),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
      mapper,
      authenticated: authenticated,
    );
  }

  /// Performs a DELETE request.
  Future<T> delete<T>(
    String path, {
    bool authenticated = false,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      (headers) =>
          _client.delete(Uri.parse('${config.baseUrl}$path'), headers: headers),
      mapper,
      authenticated: authenticated,
    );
  }

  Future<T> _performRequest<T>(
    Future<http.Response> Function(Map<String, String> headers) request,
    T Function(dynamic body, Map<String, String> headers) mapper, {
    bool authenticated = false,
  }) async {
    if (authenticated && config.accessToken == null) {
      throw const TraktApiException(
        'OAuth required for this endpoint. Please provide an accessToken in config.',
        statusCode: 401,
      );
    }

    var response = await request(
      config.getHeaders(authenticated: authenticated),
    );

    try {
      _updateRateLimit(response.headers);

      if (response.statusCode == 401 &&
          authenticated &&
          config.refreshToken != null) {
        _refreshTask ??= _doRefresh();
        await _refreshTask;
        response = await request(
          config.getHeaders(authenticated: authenticated),
        );
      }

      return await _handleResponse(response, mapper);
    } catch (e) {
      if (e is TraktApiException) rethrow;
      throw TraktApiException('Request failed: $e');
    }
  }

  Future<void> _doRefresh() async {
    try {
      await authentication.refreshToken(config.refreshToken!);
      // config and onTokenRefreshed are already updated inside AuthenticationApi
    } catch (e) {
      if (e is TraktApiException) {
        onTokenRefreshFailed?.call(e);
      }
      rethrow;
    } finally {
      _refreshTask = null;
    }
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic body, Map<String, String> headers) mapper,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final body = response.body.isEmpty ? null : jsonDecode(response.body);
      return mapper(body, response.headers);
    }

    throw TraktApiException(
      _getErrorMessage(response.statusCode),
      statusCode: response.statusCode,
      responseBody: response.body,
      rateLimit: _lastRateLimit,
    );
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request - request parameters are invalid';
      case 401:
        return 'Unauthorized - OAuth must be provided';
      case 403:
        return 'Forbidden - invalid API key or unapproved app';
      case 404:
        return 'Not Found - method exists, but no record found';
      case 405:
        return 'Method Not Allowed - method doesn\'t exist';
      case 409:
        return 'Conflict - resource already exists';
      case 422:
        return 'Unprocessable Entity - validation errors';
      case 423:
        return 'Locked - user has a locked account';
      case 429:
        return 'Rate Limit Exceeded';
      case 500:
        return 'Server Error';
      case 503:
        return 'Service Unavailable - server overloaded';
      case 504:
        return 'Service Unavailable - server overloaded';
      default:
        return 'HTTP Error $statusCode';
    }
  }

  void _updateRateLimit(Map<String, String> headers) {
    if (headers.containsKey('X-Ratelimit-Limit')) {
      _lastRateLimit = TraktRateLimit.fromHeaders(headers);
    }
  }

  /// Closes the underlying HTTP client.
  void close() {
    _client.close();
  }
}
