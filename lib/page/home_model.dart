import 'dart:math';

import 'package:covid19grapherflutter/data/repository/coronavirus_repository.dart';
import 'package:covid19grapherflutter/model/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'marker_icon_creator.dart';

class HomeModel with ChangeNotifier {
  final CoronavirusRepository _repo;

  List<Location> _locations = [];

  List<Location> get locations => _locations;

  Map<Location, Marker> _markers = {};

  Map<Location, Marker> get marker => _markers;

  set locations(List<Location> value) {
    _locations = value;
    notifyListeners();
  }

  set markers(Map<Location, Marker> value) {
    _markers = value;
    notifyListeners();
  }

  HomeModel(this._repo);

  void refresh() async {
    try {
      locations = _repo.locations();
      if (_locations.isEmpty) {
        await _repo.refreshLocations();
        locations = _repo.locations();
      }
      markers = await _createMarkers(locations);
    } catch (e, s) {
      print('HomeModel: refresh(e=$e, s=$s)');
    }
  }

  Future<Map<Location, Marker>> _createMarkers(List<Location> locations) async {
    final createFutures = locations.map((data) async {
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
