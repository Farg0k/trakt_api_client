class TraktLanguage {
  final String name;
  final String code;

  const TraktLanguage({
    required this.name,
    required this.code,
  });

  factory TraktLanguage.fromJson(Map<String, dynamic> json) {
    return TraktLanguage(
      name: json['name'] as String,
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'code': code,
    };
  }
}
