import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SportSpot Angers'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 4,
                margin: const EdgeInsets.all(12.0),
                child: ListTile(
                  leading: const Icon(Icons.search, color: Colors.deepPurple),
                  title: const Text('Trouver un lieu'),
                  onTap: () {
                    Navigator.pushNamed(context, '/search_sport_venue'); // Rediriger vers l'écran "Trouver un lieu"
                  },
                ),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.all(12.0),
                child: ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: const Text('Mes favoris'),
                  onTap: () {
                    Navigator.pushNamed(context, '/my_favorites'); // Rediriger vers l'écran "Mes favoris"
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
