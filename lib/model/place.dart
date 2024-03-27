import 'dart:async';
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  PlaceLocation(
      {required this.latitude, required this.longitute, required this.address});
  final double latitude;
  final double longitute;
  final String address;
}

class Place {
  Place({required this.name, required this.image, required this.placeLocation})
      : id = uuid.v4();

  final String id;
  final String name;
  final File image;
  final PlaceLocation placeLocation;
}
