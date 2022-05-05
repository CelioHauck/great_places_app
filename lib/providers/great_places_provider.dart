import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class GreatPlacesProvider with ChangeNotifier {
  final List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    _items.add(
      Place(
        id: DateTime.now().toString(),
        title: title,
        location: PlaceLocation(latitude: 0, longitude: 0),
        image: image,
      ),
    );
    notifyListeners();
  }
}
