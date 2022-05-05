import 'package:flutter/material.dart';
import 'package:great_places_app/providers/great_places_provider.dart';
import 'package:great_places_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<GreatPlacesProvider>(
        child: const Center(
          child: Text('Got no places yet, start adding some'),
        ),
        builder: (context, value, child) {
          final places = value.items;
          if (places.isEmpty) {
            return child!;
          }
          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(places[index].image),
                ),
                title: Text(places[index].title),
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
