class Latest {
  final int confirmed;
  final int deaths;
  final int recovered;

  const Latest(this.confirmed, this.deaths, this.recovered);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Latest &&
          runtimeType == other.runtimeType &&
          confirmed == other.confirmed &&
          deaths == other.deaths &&
          recovered == other.recovered;

  @override
  int get hashCode => confirmed.hashCode ^ deaths.hashCode ^ recovered.hashCode;

  @override
  String toString() {
    return 'Latest{confirmed: $confirmed, deaths: $deaths, recovered: $recovered}';
  }
}
