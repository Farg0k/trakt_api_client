class TraktSearchUtils {
  /// Escapes special characters that have specific meaning in the Trakt search engine.
  ///
  /// The following characters are escaped:
  /// + - && || ! ( ) { } [ ] ^ " ~ * ? : / \
  ///
  /// Use this if you want to search for a literal string that contains these characters.
  static String escape(String query) {
    if (query.isEmpty) return query;

    // Characters to escape: \ + - && || ! ( ) { } [ ] ^ " ~ * ? : /
    // Note: \ must be first to avoid double escaping
    final specialChars = [
      '\\', '+', '-', '&&', '||', '!', '(', ')', '{', '}', '[', ']', '^', '"', '~', '*', '?', ':', '/'
    ];

    var escapedQuery = query;
    for (final char in specialChars) {
      escapedQuery = escapedQuery.replaceAll(char, '\\$char');
    }

    return escapedQuery;
  }
}
