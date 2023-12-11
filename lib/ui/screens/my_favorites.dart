import 'package:flutter/material.dart';

class MyFavorites extends StatelessWidget {
  const MyFavorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes favoris"),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 191, 72), // Couleur de fond de l'écran
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
