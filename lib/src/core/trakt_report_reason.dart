enum TraktReportReason {
  spoilers('spoilers'),
  language('language'),
  abusive('abusive'),
  spam('spam'),
  bigotry('bigotry'),
  political('political'),
  offtopic('offtopic'),
  support('support'),
  duplicate('duplicate'),
  tooShort('too_short'),
  other('other');

  final String value;
  const TraktReportReason(this.value);

  @override
  String toString() => value;
}
