import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_application/models/sport_venue.dart';

class SportVenueMapView extends StatelessWidget {
  final List<SportVenue> favoriteVenues;

  const SportVenueMapView({Key? key, required this.favoriteVenues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = favoriteVenues
        .map((venue) => Marker(
              width: 80.0,
              height: 80.0,
              point: venue.coordinates,
              builder: (ctx) => const Icon(Icons.location_on, color: Colors.red),
            ))
        .toList();

    return FlutterMap(
      options: MapOptions(
        center: LatLng(47.459839, -0.588140), 
        zoom: 10.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
