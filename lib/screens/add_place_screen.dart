import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';

class AddPlacesScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlacesScreen({Key? key}) : super(key: key);

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _savePlace() {
    if (_pickedImage == null || _titleController.text.isEmpty) return;

    Provider.of<GreatPlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Spacer(),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ImageInput(addImage: _selectImage),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Place',
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
