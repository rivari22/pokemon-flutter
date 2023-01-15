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

  final DetailPage widget;
  late List<Types> types;

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
            // border: Border.all(
            //     color: Colors.grey, style: BorderStyle.solid, width: 1.0),
            color: Color(getCustomColor(types[0].typeName, 'base')),
          ),
          // child: Text("Test"),
          child: Image.network(
            "$urlImagesPokemon${widget.id}.png",
            alignment: Alignment.center,
          ),
        ),
        BlocBuilder<PokemonListBloc, PokemonListState>(
          builder: (context, state) {
            if (state is PokemonListSuccess) {
              bool isCaught =
                  state.dataPokemonList.listPokemon[widget.index].isCaught;
              if (isCaught == true) {
                return Container();
              }
              return Positioned(
                bottom: 20,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: const [
                      Icon(
                        Icons.catching_pokemon,
                        color: Colors.red,
                      ),
                      Text(
                        "Catch Pokemon",
                        style: TextStyle(color: Colors.redAccent),
                      )
                    ],
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
