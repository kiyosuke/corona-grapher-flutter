import 'dart:math';

import 'package:covid19grapherflutter/data/repository/coronavirus_repository.dart';
import 'package:covid19grapherflutter/model/location.dart';
import 'package:covid19grapherflutter/page/marker_icon_creator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState(Map<Location, Marker> markers) = _HomeState;
}

final homeProvider = StateNotifierProvider<HomeController>((ref) {
  return HomeController(ref.read(repoProvider));
});

class HomeController extends StateNotifier<HomeState> {
  final CoronavirusRepository _repo;

  HomeController(this._repo) : super(HomeState(Map())) {
    refresh();
  }

  void refresh() async {
    try {
      await _repo.refreshLocations();
      final locations = _repo.locations();
      state = state.copyWith(markers: await _createMarkers(locations));
    } catch (e, s) {
      print('HomeModel: refresh(e=$e, s=$s)');
    }
  }

  Future<Map<Location, Marker>> _createMarkers(List<Location> locations) async {
    final createFutures = locations
        .where((element) =>
            element.coordinates.latitude != null &&
            element.coordinates.longitude != null)
        .map((data) async {
      return MapEntry(
          data,
          Marker(
            markerId: MarkerId(data.id.id.toString()),
            position:
                LatLng(data.coordinates.latitude, data.coordinates.longitude),
            icon: await _createMarkerIcon(data.latest.confirmed),
          ));
    });
    return Map.fromEntries((await Future.wait(createFutures)));
  }

  Future<BitmapDescriptor> _createMarkerIcon(int confirm) {
    Color color;
    if (confirm >= 10000) {
      color = Colors.red.darker.darker;
    } else if (confirm >= 1000) {
      color = Colors.red.darker;
    } else if (confirm >= 100) {
      color = Colors.red;
    } else {
      color = Colors.red.brighter;
    }
    return MarkerIconCreator().create(confirm, color);
  }
}

extension ColorDarker on Color {
  static const brightScale = 0.7;

  Color get darker {
    final red = (this.red * brightScale).toInt();
    final green = (this.green * brightScale).toInt();
    final blue = (this.blue * brightScale).toInt();
    return Color.fromARGB(255, red, green, blue);
  }

  Color get brighter {
    final hues = [red, green, blue];
    if (hues[0] == 0 && hues[1] == 0 && hues[2] == 0) {
      hues[0] = 3;
      hues[1] = 3;
      hues[2] = 3;
    } else {
      for (var i = 0; i < 3; i++) {
        if (hues[i] > 2) {
          hues[i] = min(255, hues[i] ~/ brightScale);
        }
        if (hues[i] == 1 || hues[i] == 2) {
          hues[i] = 4;
        }
      }
    }
    return Color.fromARGB(255, hues[0], hues[1], hues[2]);
  }
}
