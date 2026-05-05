/// Common filters that can be applied to many Trakt API endpoints.
class TraktFilters {
  /// Search query to filter by title or description.
  final String? query;

  /// Filter by year (e.g., '2023' or '2020-2023').
  final String? years;

  /// Filter by genres (slugs). Multiple genres can be comma-separated.
  final List<String>? genres;

  /// Filter by languages (2-character codes).
  final List<String>? languages;

  /// Filter by countries (2-character codes).
  final List<String>? countries;

  /// Filter by content certifications (e.g., 'pg-13').
  final List<String>? certifications;

  /// Filter by networks (slugs).
  final List<String>? networks;

  /// Filter by runtime range (e.g., '30-90').
  final String? runtimes;

  /// Filter by rating range (e.g., '70-100').
  final String? ratings;

  const TraktFilters({
    this.query,
    this.years,
    this.genres,
    this.languages,
    this.countries,
    this.certifications,
    this.networks,
    this.runtimes,
    this.ratings,
  });

  /// Converts the filters to a map of query parameters.
  Map<String, String> toQueryParams() {
    final params = <String, String>{};

    if (query != null) params['query'] = query!;
    if (years != null) params['years'] = years!;
    if (genres != null && genres!.isNotEmpty) params['genres'] = genres!.join(',');
    if (languages != null && languages!.isNotEmpty) {
      params['languages'] = languages!.join(',');
    }
    if (countries != null && countries!.isNotEmpty) {
      params['countries'] = countries!.join(',');
    }
    if (certifications != null && certifications!.isNotEmpty) {
      params['certifications'] = certifications!.join(',');
    }
    if (networks != null && networks!.isNotEmpty) {
      params['networks'] = networks!.join(',');
    }
    if (runtimes != null) params['runtimes'] = runtimes!;
    if (ratings != null) params['ratings'] = ratings!;

    return params;
  }
}
