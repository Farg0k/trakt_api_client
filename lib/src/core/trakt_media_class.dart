/// High-level media classes (movies or shows).
enum TraktMediaClass {
  /// Movie class.
  movies('movies'),

  /// Show class.
  shows('shows');

  /// Creates a new [TraktMediaClass] instance.
  const TraktMediaClass(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
