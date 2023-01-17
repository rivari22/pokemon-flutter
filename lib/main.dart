import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';

import 'package:pokedex/screens/detail_screen/detail_screen.dart';
import 'package:pokedex/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PokemonListBloc()..add(GetPokemonListEvent(offset: 0)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const HomeScreen(),
          "/detail": (context) => DetailScreen(
              detailProps:
                  ModalRoute.of(context)?.settings.arguments as DetailProps)
        },
      ),
    );
  }
}
