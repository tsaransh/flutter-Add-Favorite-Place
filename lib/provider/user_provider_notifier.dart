import 'dart:io';

import 'package:favorite_place/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProviderNotifier extends StateNotifier<List<Place>> {
  UserProviderNotifier() : super(const []);

  void addPlace(String placeName, File image) {
    final Place place = Place(name: placeName, image: image);
    state = [...state, place];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserProviderNotifier, List<Place>>(
        (ref) => UserProviderNotifier());
