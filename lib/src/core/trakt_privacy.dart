enum TraktPrivacy {
  private,
  friends,
  public;

  String get value => name;

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
