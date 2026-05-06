class TraktNetwork {
  final String name;

  const TraktNetwork({required this.name});

  factory TraktNetwork.fromJson(Map<String, dynamic> json) {
    return TraktNetwork(
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
