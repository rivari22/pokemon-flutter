part of 'pokemon_list_bloc.dart';

abstract class PokemonListEvent {}

class GetPokemonListEvent extends PokemonListEvent {
  final int offset;

  GetPokemonListEvent({
    required this.offset,
  });
}

class SetPokemonCatch extends PokemonListEvent {
  final int id;

  SetPokemonCatch({
    required this.id,
  });
}
