import 'package:flutter/material.dart';
import 'package:flutter_application/blocs/favorite_bloc.dart';
import 'package:flutter_application/repositories/favorites_repository.dart';
import 'package:flutter_application/router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => FavoriteBloc(favoritesRepository: FavoritesRepository()),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SportSpot Angers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: AppRouter.routes,
      initialRoute: AppRouter.homePage,
    );
  }
}
