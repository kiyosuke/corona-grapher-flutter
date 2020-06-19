import 'package:covid19grapherflutter/data/repository/coronavirus_repository.dart';
import 'package:covid19grapherflutter/model/location.dart';
import 'package:covid19grapherflutter/page/home_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final CoronavirusRepository repo = Provider.of(context, listen: false);
    final HomeModel model = HomeModel(repo);
    model.refresh();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: ChangeNotifierProvider.value(
        value: model,
        child: Consumer<HomeModel>(
          builder: (context, model, child) {
            return Container(
                child: GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: LatLng(40.0, 140.0)),
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    markers: model.marker
                        .map((key, value) =>
                            MapEntry(key, value.copyWith(onTapParam: () {
                              showBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  builder: (context2) {
                                    return _buildBottomSheet(context2, key);
                                  });
                            })))
                        .values
                        .toSet()));
          },
        ),
      ),
    );
  }

  static final dateFormatter = DateFormat('yyyy/MM/dd HH:mm:ss');

  Widget _buildBottomSheet(BuildContext context, Location location) {
    final bottomInsets =
        MediaQuery.of(_scaffoldKey.currentState.context).viewPadding.bottom;
    return Container(
      height: 120 + bottomInsets,
      padding: EdgeInsets.only(bottom: bottomInsets),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              location.countryFullName,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 4),
            Text('最終更新日：${dateFormatter.format(location.lastUpdated)}'),
            const SizedBox(height: 4),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _buildCount(context, '感染者',
                        location.latest.confirmed, Colors.orange),
                  ),
                  Expanded(
                      child: _buildCount(context, '死亡者数',
                          location.latest.deaths, Colors.red.darker))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCount(
      BuildContext context, String title, int count, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Expanded(
          child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(count.toString(),
                  style: TextStyle(
                      color: textColor, fontWeight: FontWeight.bold))),
        )
      ],
    );
  }
}
