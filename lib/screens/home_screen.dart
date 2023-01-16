import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';

import 'package:pokedex/constants/index.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/screens/detail_screen/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _handleTap(int id, int index, String name, bool isPokemonCaught) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailPage(
            id: id, index: index, name: name, isPokemonCaught: isPokemonCaught),
      ),
    );
  }

  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions = <Widget>[
    BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        if (state is PokemonListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PokemonListSuccess) {
          return ListPokemonWidget(
            listPokemon: state.dataPokemonList.listPokemon,
            handleTap: _handleTap,
            isPokemonCaughtTab: false,
          );
        }

        return Container();
      },
    ),
    BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        if (state is PokemonListSuccess) {
          if (state.dataPokemonListCaught.isEmpty) {
            return const Center(child: Text("Kosong"));
          }
          return ListPokemonWidget(
            listPokemon: state.dataPokemonListCaught,
            handleTap: _handleTap,
            isPokemonCaughtTab: true,
          );
        }

        return Container();
      },
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Pokemon'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Pokemon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Pokemon Caught',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class ListPokemonWidget extends StatelessWidget {
  const ListPokemonWidget(
      {Key? key,
      required this.listPokemon,
      required this.handleTap,
      required this.isPokemonCaughtTab})
      : super(key: key);

  final void Function(int, int, String, bool) handleTap;
  final List<ListPokemonModel> listPokemon;
  final bool isPokemonCaughtTab;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: listPokemon.length,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      itemBuilder: (context, index) {
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
