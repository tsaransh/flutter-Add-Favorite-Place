import 'dart:io';

import 'package:favorite_place/provider/user_provider_notifier.dart';
import 'package:favorite_place/widgets/image_input.dart';
import 'package:favorite_place/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddClassScreenState();
}

class _AddClassScreenState extends ConsumerState<AddPlaceScreen> {
  late TextEditingController _titleController;

  File? _selectedImage;

  void _addPlace() {
    String placeName = _titleController.text;

    if (placeName.isEmpty || _selectedImage == null) return;

    ref.read(userPlacesProvider.notifier).addPlace(placeName, _selectedImage!);
    _titleController.clear();

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add a new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            const SizedBox(height: 4),
            ImageInput(
              onPickImage: (File image) {
                _selectedImage = image;
              },
            ),
            const SizedBox(height: 4),
            const LocationInput(),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _addPlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
