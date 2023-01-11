import 'package:flutter/material.dart';

import 'package:pokedex/constants/index.dart';
import 'package:pokedex/repository/pokemon_list_future.dart';
import 'package:pokedex/models/pokemon_list_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ListPokemon> dataPokemon = [];

  getPokemons() async {
    dataPokemon = await fetchPokemons();
    setState(() {});
  }

  @override
  void initState() {
    getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List Pokemon'),
        ),
        body: GridView.builder(
          itemCount: dataPokemon.length,
          itemBuilder: (context, index) => Card(
              semanticContainer: true,
              borderOnForeground: true,
              child: Column(
                children: [
                  Image.network(
                    "$urlImagesPokemon${dataPokemon[index].id}.png",
                    width: 50,
                  ),
                  Text(dataPokemon[index].name),
                  Text("0${dataPokemon[index].id}"),
                ],
              )),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2,
          ),
        ));
  }
}
