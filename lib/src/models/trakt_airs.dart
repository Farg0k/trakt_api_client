
/// Representation of when a show airs.
class TraktAirs {

  /// Creates a [TraktAirs] from a JSON map.
  factory TraktAirs.fromJson(Map<String, dynamic> json) {
    return TraktAirs(
      day: json['day'] as String?,
      time: json['time'] as String?,
      timezone: json['timezone'] as String?,
    );
  }
  /// Creates a new [TraktAirs] instance.
  const TraktAirs({this.day, this.time, this.timezone});

  /// Day of the week the show airs.
  final String? day;

  /// Time of the day the show airs.
  final String? time;

  /// Timezone where the show airs.
  final String? timezone;

  /// Converts this airs info to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'time': time,
      'timezone': timezone,
    };
  }
}
