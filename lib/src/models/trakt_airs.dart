class TraktAirs {
  TraktAirs({this.day, this.time, this.timezone});

  factory TraktAirs.fromJson(Map<String, dynamic> json) {
    return TraktAirs(
      day: json['day'] as String?,
      time: json['time'] as String?,
      timezone: json['timezone'] as String?,
    );
  }
  final String? day;
  final String? time;
  final String? timezone;

  Map<String, dynamic> toJson() {
    return {'day': day, 'time': time, 'timezone': timezone};
  }
}
