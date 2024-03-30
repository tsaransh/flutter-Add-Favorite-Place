import 'dart:io';

import 'package:favorite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:path_provider/path_provider.dart' as sysPath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> getDBConnection() async {
  final dbPath = sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath as String, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserProviderNotifier extends StateNotifier<List<Place>> {
  UserProviderNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await getDBConnection();
    final data = await db.query('user_places');
    final loadedPlaces = await data
        .map(
          (e) => Place(
            id: e['id'] as String,
            name: e['name'] as String,
            image: File(e['image'] as String),
            placeLocation: PlaceLocation(
                latitude: e['lat'] as double,
                longitude: e['lng'] as double,
                address: e['address'] as String),
          ),
        )
        .toList();

    state = loadedPlaces;
  }

  void addPlace(
      String placeName, File image, PlaceLocation placeLocation) async {
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final Place place = Place(
        name: placeName, image: copiedImage, placeLocation: placeLocation);

    final db = await getDBConnection();

    db.insert('user_places', {
      'id': place.id,
      'name': place.name,
      'image': place.image.path,
      'lat': place.placeLocation.latitude,
      'lng': place.placeLocation.longitude,
      'address': place.placeLocation.address
    });
    state = [...state, place];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserProviderNotifier, List<Place>>(
        (ref) => UserProviderNotifier());
