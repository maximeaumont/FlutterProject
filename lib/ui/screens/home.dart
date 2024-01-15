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
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: <Widget>[
            _buildCard(
              icon: Icons.search,
              color: Colors.deepPurple,
              title: 'Trouver un lieu',
              onTap: () => Navigator.pushNamed(context, '/search_sport_venue'),
            ),
            _buildCard(
              icon: Icons.favorite,
              color: Colors.red,
              title: 'Mes favoris',
              onTap: () => Navigator.pushNamed(context, '/my_favorites'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required IconData icon, required Color color, required String title, required VoidCallback onTap}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 80.0, color: color),
            Text(title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
