import 'package:covid19grapherflutter/data/api/coronavius_api.dart';
import 'package:covid19grapherflutter/data/db/entity/location_entity.dart';
import 'package:covid19grapherflutter/data/db/location_database.dart';
import 'package:covid19grapherflutter/data/repository/coronavirus_repository.dart';
import 'package:covid19grapherflutter/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LocationEntityAdapter());

  final database = LocationDatabase(await Hive.openBox('locations'));
  final repo = CoronavirusRepository(CoronaviusApi(), database);

  runApp(MultiProvider(
    providers: [
      Provider.value(value: repo),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
