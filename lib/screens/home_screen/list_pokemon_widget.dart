import 'package:flutter/material.dart';
import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/constants/index.dart';
import 'package:pokedex/models/pokemon_list_model.dart';

class ListPokemonWidget extends StatelessWidget {
  const ListPokemonWidget(
      {Key? key,
      required this.listPokemon,
      required this.handleTap,
      required this.isPokemonCaughtTab,
      required this.scrollController,
      required this.hasReachMaxItem})
      : super(key: key);

  final void Function(int, int, String, bool) handleTap;
  final List<ListPokemonModel> listPokemon;
  final bool isPokemonCaughtTab;
  final ScrollController scrollController;
  final bool hasReachMaxItem;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: hasReachMaxItem ? listPokemon.length : listPokemon.length + 2,
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      itemBuilder: (context, index) {
        if (index >= listPokemon.length) {
          return const Center(
            child: LinearProgressIndicator(),
          );
        }

        return GestureDetector(
          onTap: () {
            handleTap(listPokemon[index].id, index, listPokemon[index].name,
                listPokemon[index].isCaught);
          },
          child: Stack(
            children: [
              Card(
                semanticContainer: true,
                borderOnForeground: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.network(
                      "$urlImagesPokemon${listPokemon[index].id}.png",
                      width: 60,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          listPokemon[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0),
                        ),
                        Text(
                          "0${listPokemon[index].id}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    )
                  ],
                ),
              ),
              isPokemonCaughtTab
                  ? Positioned(
                      right: 5,
                      top: 6,
                      child: GestureDetector(
                        onTap: () {
                          context
                              .read<PokemonListBloc>()
                              .add(SetPokemonCatch(id: listPokemon[index].id));
                        },
                        child: const Icon(Icons.highlight_remove),
                      ),
                    )
                  : Container(),
            ],
          ),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
      ),
    );
  }
}
