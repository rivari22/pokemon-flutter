part of 'pokemon_list_bloc.dart';

abstract class PokemonListState {}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListSuccess extends PokemonListState {
  final PokemonListModel dataPokemonList;
  PokemonListSuccess(this.dataPokemonList);
}
