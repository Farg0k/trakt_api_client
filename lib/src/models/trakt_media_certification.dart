class TraktMediaCertification {
  final String certification;
  final String country;

  const TraktMediaCertification({
    required this.certification,
    required this.country,
  });

  factory TraktMediaCertification.fromJson(Map<String, dynamic> json) {
    return TraktMediaCertification(
      certification: json['certification'] as String,
      country: json['country'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'certification': certification,
      'country': country,
    };
  }
}
