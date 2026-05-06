class TraktGenre {
  final String name;
  final String slug;

  const TraktGenre({
    required this.name,
    required this.slug,
  });

  factory TraktGenre.fromJson(Map<String, dynamic> json) {
    return TraktGenre(
      name: json['name'] as String,
      slug: json['slug'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
    };
  }
}
