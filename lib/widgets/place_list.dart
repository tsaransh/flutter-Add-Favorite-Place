import 'package:favorite_place/model/place.dart';
import 'package:favorite_place/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.placeList});

  final List<Place> placeList;

  @override
  Widget build(BuildContext context) {
    if (placeList.isEmpty) {
      return Center(
          child: Text(
        'opps nothing here',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ));
    }
    return ListView.builder(
      itemCount: placeList.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(placeList[index].image),
        ),
        title: Text(
          placeList[index].name,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => PlaceDetailScreen(place: placeList[index])));
        },
      ),
    );
  }
}
