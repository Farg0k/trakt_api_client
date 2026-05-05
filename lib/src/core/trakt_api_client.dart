import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/authentication_api.dart';
import '../api/movies_api.dart';
import '../api/shows_api.dart';
import 'trakt_api_config.dart';
import 'trakt_api_exception.dart';
import 'trakt_rate_limit.dart';

class TraktApiClient {
  final TraktApiClientConfig config;
  final http.Client _client;
  final void Function(TraktRateLimit)? onRateLimitChanged;

  TraktRateLimit? _lastRateLimit;
  TraktRateLimit? get lastRateLimit => _lastRateLimit;

  late final AuthenticationApi auth;
  late final MoviesApi movies;
  late final ShowsApi shows;

  TraktApiClient({
    required this.config,
    http.Client? client,
    this.onRateLimitChanged,
  }) : _client = client ?? http.Client() {
    auth = AuthenticationApi(this);
    movies = MoviesApi(this);
    shows = ShowsApi(this);
  }

  Future<T> get<T>(
    String path, {
    Map<String, String>? queryParams,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    final uri = Uri.parse('${config.baseUrl}$path').replace(
      queryParameters: queryParams,
    );

    final response = await _client.get(
      uri,
      headers: config.headers,
    );

    return _handleResponse(response, mapper);
  }

  Future<T> post<T>(
    String path, {
    dynamic body,
    required T Function(dynamic body, Map<String, String> headers) mapper,
  }) async {
    final uri = Uri.parse('${config.baseUrl}$path');

    final response = await _client.post(
      uri,
      headers: config.headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response, mapper);
  }

  T _handleResponse<T>(
    http.Response response,
    T Function(dynamic body, Map<String, String> headers) mapper,
  ) {
    _updateRateLimit(response.headers);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final dynamic body = response.body.isEmpty ? null : jsonDecode(response.body);
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
        message = 'Conflict - resource already created';
        break;
      case 410:
        message = 'Account Deactivated - have the user contact support';
        break;
      case 412:
        message = 'Precondition Failed - use application/json';
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
