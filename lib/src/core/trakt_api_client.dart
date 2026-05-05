import 'dart:convert';
import 'package:http/http.dart' as http;
import '../api/movies_api.dart';
import '../api/shows_api.dart';
import 'trakt_api_config.dart';
import 'trakt_api_exception.dart';

class TraktApiClient {
  final TraktApiClientConfig config;
  final http.Client _client;

  late final MoviesApi movies;
  late final ShowsApi shows;

  TraktApiClient({
    required this.config,
    http.Client? client,
  }) : _client = client ?? http.Client() {
    movies = MoviesApi(this);
    shows = ShowsApi(this);
  }

  Future<dynamic> get(String path, {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('${config.baseUrl}$path').replace(
      queryParameters: queryParams,
    );

    final response = await _client.get(
      uri,
      headers: config.headers,
    );

    return _handleResponse(response);
  }

  Future<dynamic> post(String path, {dynamic body}) async {
    final uri = Uri.parse('${config.baseUrl}$path');

    final response = await _client.post(
      uri,
      headers: config.headers,
      body: body != null ? jsonEncode(body) : null,
    );

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      throw TraktApiException(
        'Request failed with status: ${response.statusCode}',
        response.statusCode,
      );
    }
  }

  void close() {
    _client.close();
  }
}
