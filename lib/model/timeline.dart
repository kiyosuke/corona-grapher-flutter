class Timeline {
  final int latest;
  final Map<DateTime, int> timeline;

  const Timeline(this.latest, this.timeline);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Timeline &&
          runtimeType == other.runtimeType &&
          latest == other.latest &&
          timeline == other.timeline;

  @override
  int get hashCode => latest.hashCode ^ timeline.hashCode;

  @override
  String toString() {
    return 'Timeline{latest: $latest, timeline: $timeline}';
  }
}
