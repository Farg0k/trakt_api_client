class TraktUser {
  final String? username;
  final bool? private;
  final String? name;
  final bool? vip;
  final bool? vipEp;
  final String? ids; // Usually just slug or UUID in comments

  const TraktUser({
    this.username,
    this.private,
    this.name,
    this.vip,
    this.vipEp,
    this.ids,
  });

  factory TraktUser.fromJson(Map<String, dynamic> json) {
    return TraktUser(
      username: json['username'] as String?,
      private: json['private'] as bool?,
      name: json['name'] as String?,
      vip: json['vip'] as bool?,
      vipEp: json['vip_ep'] as bool?,
      ids: json['ids']?['slug'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'private': private,
      'name': name,
      'vip': vip,
      'vip_ep': vipEp,
      'ids': {'slug': ids},
    };
  }
}
