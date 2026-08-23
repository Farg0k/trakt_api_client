/// Utilities for escaping Trakt search queries.
class TraktSearchUtils {
  /// Internal client reference.
  const TraktSearchUtils();

  /// Escapes special characters in a search query.
  ///
  /// Special characters (+ - && || ! ( ) { } `[ ]` ^ " ~ * ? : / \)
  /// will be escaped with a backslash to be interpreted literally by the
  /// Lucene search engine used by Trakt.
  static String escape(String query) {
    final specials = RegExp(r'([\+\-&&\|\|!\(\)\{\}\[\]\^"~\*\?\:\/\\ ])');
    return query.replaceAllMapped(specials, (match) => '\\${match.group(0)}');
  }
}
