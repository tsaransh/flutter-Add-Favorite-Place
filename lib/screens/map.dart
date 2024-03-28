import 'package:flutter/material.dart';
import 'package:favorite_place/model/place.dart'; // Assuming PlaceLocation is defined in 'place.dart'

class MapScreen extends StatefulWidget {
  const MapScreen(
      {super.key,
      this.location = const PlaceLocation(
          latitude: 37.22, longitude: -122.084, address: '')});

  final PlaceLocation location;

  @override
  State<MapScreen> createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
