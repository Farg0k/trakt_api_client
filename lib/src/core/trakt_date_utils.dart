class TraktDateUtils {
  /// Safely parses a date string from the API.
  /// 
  /// Trakt sometimes returns null or malformed strings for dates 
  /// (e.g. "0000-00-00" in some edge cases or empty strings).
  static DateTime? parse(dynamic value) {
    if (value == null || value is! String || value.isEmpty) return null;
    
    // Handle edge case where Trakt might return "0000-00-00" 
    if (value.startsWith('0000')) return null;
    
    return DateTime.tryParse(value);
  }

  /// Formats a DateTime to the YYYY-MM-DD format required by some paths.
  static String formatPathDate(DateTime date) {
    return date.toUtc().toIso8601String().split('T')[0];
  }

  /// Formats a DateTime to the full ISO 8601 UTC string.
  static String formatFullDate(DateTime date) {
    return date.toUtc().toIso8601String();
  }
}
