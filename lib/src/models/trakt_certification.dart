class TraktCertification {
  final String name;
  final String slug;
  final String description;

  const TraktCertification({
    required this.name,
    required this.slug,
    required this.description,
  });

  factory TraktCertification.fromJson(Map<String, dynamic> json) {
    return TraktCertification(
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'slug': slug,
      'description': description,
    };
  }
}
