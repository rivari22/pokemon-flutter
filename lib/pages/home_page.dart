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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        itemBuilder: (context, index) => Card(
            semanticContainer: true,
            borderOnForeground: true,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                  "$urlImagesPokemon${dataPokemon[index].id}.png",
                  width: 60,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dataPokemon[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                    Text(
                      "0${dataPokemon[index].id}",
                      style: const TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w300),
                    )
                  ],
                )
              ],
            )),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2,
        ),
      ),
    );
  }
}
