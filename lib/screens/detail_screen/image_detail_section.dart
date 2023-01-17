import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/constants/custom_color.dart';
import 'package:pokedex/constants/index.dart';
import 'package:pokedex/models/pokemon_detail_model.dart';
import 'package:pokedex/screens/detail_screen/detail_screen.dart';

// ignore: must_be_immutable
class ImageDetailSection extends StatelessWidget {
  ImageDetailSection({Key? key, required this.widget, required this.types})
      : super(key: key);

  final DetailScreen widget;
  late List<Types> types;

  void _handleTapPokemon(BuildContext context) {
    // NOTES: Handle release pokemon
    if (widget.detailProps.isPokemonCaught) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully release pokemon"),
        ),
      );
      context
          .read<PokemonListBloc>()
          .add(SetPokemonCatch(id: widget.detailProps.id));
      Navigator.pop(context);
      return;
    }

    // NOTES: HANDLE Catch pokemon with 50:50 chance
    Random random = Random();
    int randomNumber = random.nextInt(10);
    bool isCaught = randomNumber > 5;
    if (isCaught) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Congratulation, you got it"),
        ),
      );
      context
          .read<PokemonListBloc>()
          .add(SetPokemonCatch(id: widget.detailProps.id));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to catch, you can try again"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
              left: 80.0, right: 80.0, top: 10.0, bottom: 50.0),
          margin: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
              topLeft: Radius.circular(10.0),
            ),
            color: Color(getCustomColor(types[0].typeName, 'base')),
          ),
          child: Image.network(
            "$urlImagesPokemon${widget.detailProps.id}.png",
            alignment: Alignment.center,
          ),
        ),
        BlocBuilder<PokemonListBloc, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListSuccess) {
              return Positioned(
                bottom: 10,
                child: TextButton(
                  onPressed: () {
                    _handleTapPokemon(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color(
                        getCustomColor(types[0].typeName, 'background'),
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.catching_pokemon,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.detailProps.isPokemonCaught
                              ? "Release Pokemon"
                              : "Catch Pokemon",
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }

            return Container();
          },
        )
      ],
    );
  }
}
