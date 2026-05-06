class TraktCountry {
  final String name;
  final String code;

  const TraktCountry({
    required this.name,
    required this.code,
  });

  factory TraktCountry.fromJson(Map<String, dynamic> json) {
    return TraktCountry(
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
