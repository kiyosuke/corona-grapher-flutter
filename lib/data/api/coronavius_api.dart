import 'dart:convert';

import 'package:covid19grapherflutter/data/api/response/latest_response.dart';
import 'package:covid19grapherflutter/data/api/response/location_response.dart';
import 'package:covid19grapherflutter/data/api/response/locations_response.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:http/http.dart' as http;

import 'api_exception.dart';

final apiProvider = Provider<CoronaviusApi>((_) {
  return CoronaviusApi();
});

class CoronaviusApi {
  static const base_url = 'https://coronavirus-tracker-api.herokuapp.com/v2/';

  static const locations_endpoint = 'locations';

  static const latest_endpoint = 'latest';

  Future<LocationsResponse> allLocations() async {
    final response = await http.get(base_url + locations_endpoint);

    if (response.statusCode == 200) {
      return LocationsResponse.fromJson(json.decode(response.body));
    } else {
      throw ApiException(response.statusCode);
    }
  }

  Future<LatestResponse> latest() async {
    final response = await http.get(base_url + latest_endpoint);
    if (response.statusCode == 200) {
      return LatestResponse.fromJson(json.decode(response.body));
    } else {
      throw ApiException(response.statusCode);
    }
  }

  Future<LocationResponse> location(int id) async {
    final response = await http.get(base_url + locations_endpoint + '$id');
    if (response.statusCode == 200) {
      return LocationResponse.fromJson(json.decode(response.body));
    } else {
      throw ApiException(response.statusCode);
    }
  }
}
