import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/authentication_api.dart';
import '../api/calendars_api.dart';
import '../api/certifications_api.dart';
import '../api/checkin_api.dart';
import '../api/comments_api.dart';
import '../api/countries_api.dart';
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
import '../api/shows_api.dart';
import '../models/trakt_auth_models.dart';
import 'trakt_api_config.dart';
import 'trakt_api_exception.dart';
import 'trakt_rate_limit.dart';

class TraktApiClient {
  TraktApiClientConfig config;
  final http.Client _client;
  final void Function(TraktRateLimit)? onRateLimitChanged;
  final void Function(TraktOAuthToken)? onTokenRefreshed;

  TraktRateLimit? _lastRateLimit;
  TraktRateLimit? get lastRateLimit => _lastRateLimit;

  late final AuthenticationApi auth;
  late final MoviesApi movies;
  late final ShowsApi shows;
  late final CalendarsApi calendars;
  late final CheckinApi checkin;
  late final CommentsApi comments;
  late final CertificationsApi certifications;
  late final CountriesApi countries;
  late final GenresApi genres;
  late final LanguagesApi languages;
  late final ListsApi lists;
  late final NetworksApi networks;
  late final NotesApi notes;
  late final PeopleApi people;
  late final RecommendationsApi recommendations;
  late final ScrobbleApi scrobble;
  late final SearchApi search;

  TraktApiClient({
    required this.config,
    http.Client? client,
    this.onRateLimitChanged,
    this.onTokenRefreshed,
  }) : _client = client ?? http.Client() {
    auth = AuthenticationApi(this);
    movies = MoviesApi(this);
    shows = ShowsApi(this);
    calendars = CalendarsApi(this);
    checkin = CheckinApi(this);
    comments = CommentsApi(this);
    certifications = CertificationsApi(this);
    countries = CountriesApi(this);
    genres = GenresApi(this);
    languages = LanguagesApi(this);
    lists = ListsApi(this);
    networks = NetworksApi(this);
    notes = NotesApi(this);
    people = PeopleApi(this);
    recommendations = RecommendationsApi(this);
    scrobble = ScrobbleApi(this);
    search = SearchApi(this);
  }

  Future<T> get<T>(
    String path, {
    Map<String, String>? queryParams,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      () => _client.get(
        Uri.parse('${config.baseUrl}$path').replace(queryParameters: queryParams),
        headers: config.headers,
      ),
      mapper,
    );
  }

  Future<T> post<T>(
    String path, {
    dynamic body,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      () => _client.post(
        Uri.parse('${config.baseUrl}$path'),
        headers: config.headers,
        body: body != null ? jsonEncode(body) : null,
      ),
      mapper,
    );
  }

  Future<T> put<T>(
    String path, {
    dynamic body,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      () => _client.put(
        Uri.parse('${config.baseUrl}$path'),
        headers: config.headers,
        body: body != null ? jsonEncode(body) : null,
      ),
      mapper,
    );
  }

  Future<T> delete<T>(
    String path, {
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    return _performRequest(
      () => _client.delete(
        Uri.parse('${config.baseUrl}$path'),
        headers: config.headers,
      ),
      mapper,
    );
  }

  Future<T> _performRequest<T>(
    Future<http.Response> Function() request,
    T Function(dynamic body, Map<String, String> headers) mapper,
  ) async {
    var response = await request();

    try {
      return _handleResponse(response, mapper);
    } catch (e) {
      if (e is TraktApiException &&
          e.statusCode == 401 &&
          config.refreshToken != null &&
          config.clientSecret != null) {
        // Attempt to refresh token
        try {
          final newToken = await auth.refreshToken(config.refreshToken!);
          config = config.copyWith(
            accessToken: newToken.accessToken,
            refreshToken: newToken.refreshToken,
          );
          onTokenRefreshed?.call(newToken);

          // Retry the request with new token
          response = await request();
          return _handleResponse(response, mapper);
        } catch (refreshError) {
          // If refresh fails, throw original 401
          throw e;
        }
      }
      rethrow;
    }
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic body, Map<String, String> headers) mapper,
  ) {
    _updateRateLimit(response.headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final dynamic body =
          response.body.isEmpty ? null : jsonDecode(response.body);
      return mapper(body, response.headers);
    }

    final String message;
    switch (response.statusCode) {
      case 400:
        message = 'Bad Request - request couldn\'t be parsed';
        break;
      case 401:
        message = 'Unauthorized - OAuth must be provided';
        break;
      case 403:
        message = 'Forbidden - invalid API key or unapproved app';
        break;
      case 404:
        message = 'Not Found - method exists, but no record found';
        break;
      case 405:
        message = 'Method Not Found - method doesn\'t exist';
        break;
      case 409:
        message = 'Conflict - resource already created or already approved';
        break;
      case 410:
        message = 'Account Deactivated or Token Expired - restart the process';
        break;
      case 412:
        message = 'Precondition Failed - use application/json';
        break;
      case 418:
        message = 'Denied - user explicitly denied this code';
        break;
      case 420:
        message = 'Account Limit Exceeded - list count, item count, etc';
        break;
      case 422:
        message = 'Unprocessable Entity - validation errors';
        break;
      case 423:
        message = 'Locked User Account - have the user contact support';
        break;
      case 426:
        message = 'VIP Only - user must upgrade to VIP';
        break;
      case 429:
        message = 'Rate Limit Exceeded';
        break;
      case 500:
        message = 'Server Error';
        break;
      case 503:
      case 504:
        message = 'Service Unavailable - server overloaded (try again later)';
        break;
      default:
        message = 'Request failed with status: ${response.statusCode}';
    }

    throw TraktApiException(
      message,
      statusCode: response.statusCode,
      responseBody: response.body,
      rateLimit: _lastRateLimit,
    );
  }

  void _updateRateLimit(Map<String, String> headers) {
    if (headers.containsKey('X-Ratelimit-Limit')) {
      _lastRateLimit = TraktRateLimit.fromHeaders(headers);
      onRateLimitChanged?.call(_lastRateLimit!);
    }
  }

  void close() {
    _client.close();
  }
}
