/// Privacy settings for lists and notes.
enum TraktPrivacy {
  /// Private (only visible to the user).
  private,

  /// Friends (visible to friends).
  friends,

  /// Public (visible to everyone).
  public;

  /// The value used in API requests.
  String get value => name;

  /// Creates a [TraktPrivacy] from a string value.
  static TraktPrivacy fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'friends':
        return TraktPrivacy.friends;
      case 'public':
        return TraktPrivacy.public;
      case 'private':
      default:
        return TraktPrivacy.private;
    }
  }

  @override
  String toString() => name;
}
