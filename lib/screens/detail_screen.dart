import 'package:flutter/material.dart';
import 'package:pokedex/constants/index.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id, required this.mockData});
  final Map<String, Object> mockData;

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bulbasaur"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 1.4,
        children: [
          Stack(
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
                  border: Border.all(
                      color: Colors.grey, style: BorderStyle.solid, width: 1.0),
                  color: Colors.white,
                ),
                // child: Text("Test"),
                child: Image.network(
                  "$urlImagesPokemon$id.png",
                  alignment: Alignment.center,
                ),
              ),
              Positioned(
                bottom: 20,
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
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
              )
            ],
          ),
          const TabBarDetail(),
        ],
      ),
    );
  }
}

class TabBarDetail extends StatelessWidget {
  const TabBarDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
        body: TabBarView(children: [
          Container(
            padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                top: 10.0,
                bottom: 10.0), // should edit
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
              border: Border.all(
                  color: Colors.grey, style: BorderStyle.solid, width: 1.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [Text('1 KG'), Text('WEIGHT')],
                    ),
                    Column(
                      children: [Text('64'), Text('Base Experience')],
                    ),
                    Column(
                      children: [Text('0.2 M'), Text('HEIGHT')],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.green),
                            ),
                            Text("GRASS")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 2.0, left: 2.0),
                          child: Text('/'),
                        ),
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.purple),
                            ),
                            Text("POISON")
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 5,
                          child: Text('Sprites'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
                              width: 100,
                              height: 100,
                            ),
                            Image.network(
                              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                              width: 100,
                              height: 100,
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
          TabContentStats(),
        ]),
      ),
    );
  }
}

class TabContentStats extends StatelessWidget {
  const TabContentStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 1),
                child: SizedBox(
                  width: 100,
                  child: index == 1 ? Text("special-attack") : Text("HP"),
                ),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: double.parse("0.$index"),
                  color: Colors.blueAccent,
                  backgroundColor: Colors.blue.shade100,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
