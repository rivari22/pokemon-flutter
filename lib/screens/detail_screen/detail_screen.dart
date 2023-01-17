import 'package:flutter/material.dart';
import 'package:pokedex/repository/pokemon_detail_future.dart';
import 'package:pokedex/screens/detail_screen/image_detail_section.dart';
import 'package:pokedex/screens/detail_screen/tabbar_detail_section.dart';

import '../../constants/custom_color.dart';
import '../../models/pokemon_detail_model.dart';

class DetailProps {
  final int id;
  final String name;
  final bool isPokemonCaught;

  const DetailProps(
      {required this.id, required this.name, required this.isPokemonCaught});
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.detailProps});
  final DetailProps detailProps;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<PokemonDetailModel> futurePokemonDetail;

  @override
  void initState() {
    futurePokemonDetail = fetchPokemonDetail(widget.detailProps.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.detailProps.name),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
          future: futurePokemonDetail,
          builder: (BuildContext context,
              AsyncSnapshot<PokemonDetailModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                    color: Color(getCustomColor(
                        snapshot.data!.types[0].typeName, 'base'))),
                child: GridView.count(
                  crossAxisCount: 1,
                  childAspectRatio: 1.4,
                  children: [
                    ImageDetailSection(
                      widget: widget,
                      types: snapshot.data!.types,
                    ),
                    TabBarDetail(
                      dataPokemon: snapshot.data!,
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Error, No data"),
              );
            }

            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
