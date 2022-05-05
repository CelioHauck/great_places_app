import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final void Function(File file) _addImage;

  const ImageInput({
    Key? key,
    required void Function(File file) addImage,
  })  : _addImage = addImage,
        super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, maxHeight: 600);
    // final image = await ImagePicker.platform.pickImage(
    //   source: ImageSource.camera,
    //   maxWidth: 600,
    // );

    if (image == null) return;

    setState(() {
      _storedImage = File(image.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final pathString = path.basename(image.path);
    final savedImage =
        await File(image.path).copy('${appDir.path}/$pathString');
    widget._addImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text('No image taken'),
          alignment: Alignment.center,
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Take picture'),
            style: TextButton.styleFrom(
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              primary: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
