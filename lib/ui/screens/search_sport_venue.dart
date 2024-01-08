import 'package:flutter/material.dart';
import 'package:flutter_application/models/sport_venue.dart';
import 'package:flutter_application/repositories/sport_venue_repository.dart';

class SearchSportVenue extends StatefulWidget {
  const SearchSportVenue({super.key});

  @override
  State<SearchSportVenue> createState() => _SearchSportVenueState();
}

class _SearchSportVenueState extends State<SearchSportVenue> {
  List<SportVenue> _sportvenues = [];
  List<String> listOfChoices = [
    'Choisissez un sport',
    'Football',
    'Badminton',
    'Judo',
    'Basket-ball',
    'Tennis',
    'Aviron',
    'Course',
    'Handball',
    'Natation',
    'Boxe',
    'Musculation'
  ];

  String selectedSport = 'Choisissez un sport';

  void _onSearchChanged(String? value) {
    if (value != null) {
      final sportVenueRepository = SportVenueRepository();
      sportVenueRepository.fetchSportVenues(value).then((value) {
        setState(() {
          _sportvenues = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lieux sportifs à Angers"),
      ),
      body: Container(
        color: const Color.fromARGB(255, 187, 179, 180),
        child: Column(
          children: [
            DropdownButton(
                value: selectedSport,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items:
                    listOfChoices.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _onSearchChanged(newValue);
                    selectedSport = newValue;
                  }
                }),
            Expanded(
              child: ListView.separated(
                itemCount: _sportvenues.length,
                itemBuilder: (context, index) {
                  final sportVenue = _sportvenues[index];
                  return ListTile(
                      leading: const Icon(Icons.place),
                      title: Text(sportVenue.name ?? 'Nom non disponible'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Mail : ${sportVenue.mail}'), //pas très utile mais l'api nous donne que cette adresse, avec cette API pas pertinent d'afficher le mail pour l'utilisateur mais si l'API fournirait les mails correctement on pourrait gardercette affichage
                          Text(sportVenue.numberOfPlaces != '0'
                              ? 'Nombre de places : ${sportVenue.numberOfPlaces}'
                              : ''),
                        ],
                      ));
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
