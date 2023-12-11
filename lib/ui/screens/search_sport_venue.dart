import 'package:flutter/material.dart';

class SearchSportVenue extends StatelessWidget {
  const SearchSportVenue({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lieux sportifs à Angers"),
      ),
      body: Container(
        color: Color.fromARGB(255, 173, 14, 41), // Couleur de fond de l'écran
        child: const Center(
          child: Text(
            'Bonjour Flutter !',
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
