/// Utility class for Trakt date operations.
class TraktDateUtils {
  /// Internal client reference.
  const TraktDateUtils();

  /// Parses a value into a [DateTime] object.
  static DateTime? parse(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      if (value == '0000-00-00') return null;
      return DateTime.tryParse(value);
    }
    return null;
  }

  /// Formats a [DateTime] for use in URL paths (YYYY-MM-DD).
  static String formatPathDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Formats a [DateTime] to a full ISO 8601 string.
  static String formatFullDate(DateTime date) {
    return date.toIso8601String();
  }
}
