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
    List<Marker> markers = favoriteVenues.map((venue) {
      return Marker(
        width: 200.0,
        height: 100.0,
        point: venue.coordinates,
        builder: (ctx) => _buildCustomMarker(venue),
      );
    }).toList();

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
        MarkerLayer(markers: markers),
      ],
    );
  }

  Widget _buildCustomMarker(SportVenue venue) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Expanded(
            child: Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
          Text(venue.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}