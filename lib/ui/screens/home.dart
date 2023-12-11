import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ecran d'accueil"),
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/search_sport_venue'); // Rediriger vers l'écran 1
                },
                child: const Text('Chercher un lieu'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/my_favorites'); // Rediriger vers l'écran 2
                },
                child: const Text('Mes favoris'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
