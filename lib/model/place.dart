import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({required this.name, required this.image}) : id = uuid.v4();

  final String id;
  final String name;
  final File image;
}
