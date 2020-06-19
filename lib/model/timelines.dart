import 'package:covid19grapherflutter/model/timeline.dart';

class Timelines {
  final Timeline confirmed;
  final Timeline deaths;
  final Timeline recovered;

  const Timelines(this.confirmed, this.deaths, this.recovered);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Timelines &&
          runtimeType == other.runtimeType &&
          confirmed == other.confirmed &&
          deaths == other.deaths &&
          recovered == other.recovered;

  @override
  int get hashCode => confirmed.hashCode ^ deaths.hashCode ^ recovered.hashCode;

  @override
  String toString() {
    return 'Timelines{confirmed: $confirmed, deaths: $deaths, recovered: $recovered}';
  }
}
