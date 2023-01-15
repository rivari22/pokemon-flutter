import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';

import 'package:pokedex/constants/index.dart';
import 'package:pokedex/screens/detail_screen/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleTap(String id, int index, String name) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(
          id: id,
          index: index,
          name: name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pokemon'),
      ),
      body: BlocBuilder<PokemonListBloc, PokemonListState>(
        builder: (context, state) {
          if (state is PokemonListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PokemonListSuccess) {
            return GridView.builder(
              itemCount: state.dataPokemonList.listPokemon.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  _handleTap(state.dataPokemonList.listPokemon[index].id, index,
                      state.dataPokemonList.listPokemon[index].name);
                },
                child: Card(
                    semanticContainer: true,
                    borderOnForeground: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.network(
                          "$urlImagesPokemon${state.dataPokemonList.listPokemon[index].id}.png",
                          width: 60,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              state.dataPokemonList.listPokemon[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.0),
                            ),
                            Text(
                              "0${state.dataPokemonList.listPokemon[index].id}",
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2,
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
