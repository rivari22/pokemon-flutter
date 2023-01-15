import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';

import 'package:pokedex/constants/index.dart';
import 'package:pokedex/mocks/index.dart';
import 'package:pokedex/screens/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonListBloc _pokemonListBloc = PokemonListBloc();

  getPokemons() async {
    _pokemonListBloc.add(GetPokemonListEvent());
    setState(() {});
  }

  @override
  void initState() {
    getPokemons();
    super.initState();
  }

  void _handleTap(String id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(id: id, mockData: mockData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pokemon'),
      ),
      body: BlocProvider(
        create: (context) => _pokemonListBloc,
        child: BlocBuilder(
          bloc: _pokemonListBloc,
          builder: (context, state) {
            if (state is PokemonListLoading) {
              return const CircularProgressIndicator(
                strokeWidth: 5.0,
              );
            }

            if (state is PokemonListSuccess) {
              return GridView.builder(
                itemCount: state.dataPokemonList.listPokemon.length,
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    _handleTap(state.dataPokemonList.listPokemon[index].id);
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
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
      ),
    );
  }
}
