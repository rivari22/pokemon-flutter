import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pokedex/bloc/pokemon_list_bloc/pokemon_list_bloc.dart';
import 'package:pokedex/screens/detail_screen/detail_screen.dart';
import 'package:pokedex/screens/home_screen/list_pokemon_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PokemonListBloc _pokemonListBloc;

  final _scrollController = ScrollController();

  int _selectedIndex = 0;
  int _offsetPage = 0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _pokemonListBloc = context.read<PokemonListBloc>();
    super.initState();
  }

  void _handleTap(int id, int index, String name, bool isPokemonCaught) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            DetailPage(id: id, name: name, isPokemonCaught: isPokemonCaught),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _widgetOptions = <Widget>[
    BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        if (state is PokemonListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PokemonListSuccess) {
          return ListPokemonWidget(
            listPokemon: state.dataPokemonList.listPokemon,
            hasReachMaxItem: state.dataPokemonList.next == null,
            handleTap: _handleTap,
            isPokemonCaughtTab: false,
            scrollController: _scrollController,
          );
        }

        return Container();
      },
    ),
    BlocBuilder<PokemonListBloc, PokemonListState>(
      builder: (context, state) {
        if (state is PokemonListSuccess) {
          if (state.dataPokemonListCaught.isEmpty) {
            return const Center(child: Text("Empty Pokemon"));
          }
          return ListPokemonWidget(
            listPokemon: state.dataPokemonListCaught,
            hasReachMaxItem: true,
            handleTap: _handleTap,
            isPokemonCaughtTab: true,
            scrollController: _scrollController,
          );
        }

        return Container();
      },
    ),
  ];

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
            icon: Icon(Icons.catching_pokemon),
            label: 'Pokemon Caught',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        _selectedIndex == 0) {
      _offsetPage += 10;
      _pokemonListBloc.add(GetPokemonListEvent(offset: _offsetPage));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
