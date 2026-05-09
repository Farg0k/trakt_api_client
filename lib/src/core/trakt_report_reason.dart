/// Reasons for reporting content.
enum TraktReportReason {
  /// Contains spoilers.
  spoilers('spoilers'),

  /// Inappropriate language.
  language('language'),

  /// Abusive content.
  abusive('abusive'),

  /// Spam content.
  spam('spam'),

  /// Contains bigotry.
  bigotry('bigotry'),

  /// Political content.
  political('political'),

  /// Off-topic content.
  offtopic('offtopic'),

  /// Support request (inappropriate here).
  support('support'),

  /// Duplicate content.
  duplicate('duplicate'),

  /// Comment is too short.
  tooShort('too_short'),

  /// Other reason.
  other('other');

  /// Creates a new [TraktReportReason] instance.
  const TraktReportReason(this.value);

  /// The value used in API requests.
  final String value;

  @override
  String toString() => value;
}
