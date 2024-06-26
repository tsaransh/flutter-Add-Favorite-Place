import 'dart:convert';

import 'package:favorite_place/model/place.dart';
import 'package:favorite_place/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onPickLocation});

  final void Function(PlaceLocation placeLocation) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  late PlaceLocation _pickedLocation;
  bool _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) return '';
    final lat = _pickedLocation.latitude;
    final lon = _pickedLocation.longitude;
    const googleMapApiKey = 'YOUR_API_KEY_HERE';

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$lat,$lon&key=$googleMapApiKey";
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    const googleMapApiKey = "_YOUR_API_KEY_";
    final url = Uri.parse(
        "https://googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$googleMapApiKey");

    final response = await http.get(url);
    final responseData = json.decode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(
          latitude: latitude, longitude: longitude, address: address);
      _isGettingLocation = false;
    });

    widget.onPickLocation(_pickedLocation);
  }

  void _getCurrentLocation() async {
    Location location = Location();
    bool serviceEnables;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnables = await location.serviceEnabled();
    if (!serviceEnables) {
      serviceEnables = await location.serviceEnabled();
    }
    if (!serviceEnables) {
      return;
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) return;

    _savePlace(latitude, longitude);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (pickedLocation == null) return;

    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      'No location is selected at that moment',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) {
      content = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: content),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('get current location')),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('select on map'))
          ],
        )
      ],
    );
  }
}
