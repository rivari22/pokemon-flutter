import 'package:flutter/material.dart';
import 'package:pokedex/constants/custom_color.dart';
import 'package:pokedex/models/pokemon_detail_model.dart';

// ignore: must_be_immutable
class TabBarDetail extends StatelessWidget {
  TabBarDetail({Key? key, required this.dataPokemon}) : super(key: key);

  late PokemonDetailModel dataPokemon;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Color(getCustomColor(dataPokemon.types[0].typeName, 'base')),
          elevation: 0.0,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.catching_pokemon_outlined,
                        color: Colors.black,
                      ),
                      Text(
                        'Detail',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.stacked_line_chart_sharp,
                        color: Colors.black,
                      ),
                      Text('Stats', style: TextStyle(color: Colors.black))
                    ],
                  ),
                )
              ]),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color:
                  Color(getCustomColor(dataPokemon.types[0].typeName, 'base'))),
          child: TabBarView(children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 1.0),
                color: Color(getCustomColor(
                    dataPokemon.types[0].typeName, 'background')),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text('${dataPokemon.weight} KG'),
                          const Text('WEIGHT')
                        ],
                      ),
                      Column(
                        children: [
                          Text('${dataPokemon.baseExperience}'),
                          const Text('Base Experience')
                        ],
                      ),
                      Column(
                        children: [
                          Text('${dataPokemon.height * 0.01} M'),
                          const Text('HEIGHT')
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: dataPokemon.types
                        .map(
                          (e) => Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: Color(getCustomColor(
                                              e.typeName, 'base'))),
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(e.typeName.toUpperCase())
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const Positioned(
                            top: 0,
                            child: Text('Sprites'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                dataPokemon.spriteBackDefault,
                                width: 90,
                                height: 90,
                              ),
                              const SizedBox(width: 40),
                              Image.network(
                                dataPokemon.spriteFrontDefault,
                                width: 90,
                                height: 90,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: dataPokemon.stats.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: SizedBox(
                          width: 100,
                          child: Text(dataPokemon.stats[index].baseName),
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: dataPokemon.stats[index].baseStat * 0.01,
                          color: Colors.blueAccent,
                          backgroundColor: Colors.blue.shade100,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
