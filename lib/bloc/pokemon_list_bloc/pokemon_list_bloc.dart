import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repository/pokemon_list_future.dart';
import '../../models/pokemon_list_model.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc() : super(PokemonListInitial()) {
    on<GetPokemonListEvent>((event, emit) async {
      // NOTES: HANDLE INFINITE SCROLL
      final state = this.state;
      if (state is PokemonListSuccess) {
        if (state.dataPokemonList.next == null ||
            state.dataPokemonList.next!.isEmpty) {
          return;
        }

        final response = await fetchPokemons(event.offset);
        state.dataPokemonList.count = response.count;
        state.dataPokemonList.next = response.next;
        state.dataPokemonList.previous = response.previous;
        state.dataPokemonList.listPokemon = [
          ...state.dataPokemonList.listPokemon,
          ...response.listPokemon,
        ];

        emit(PokemonListSuccess(
            dataPokemonList: state.dataPokemonList,
            dataPokemonListCaught: state.dataPokemonListCaught));
      } else {
        // NOTES: Init fetch
        emit(PokemonListLoading());
        final response = await fetchPokemons(event.offset);
        if (response.previous == null || response.previous!.isEmpty) {}
        emit(PokemonListSuccess(
            dataPokemonList: response, dataPokemonListCaught: []));
      }
    });

    on<SetPokemonCatch>((event, emit) {
      final state = this.state;
      if (state is PokemonListSuccess) {
        for (var element in state.dataPokemonList.listPokemon) {
          if (element.id == event.id) {
            element.isCaught = !element.isCaught;
            break;
          }
        }

        List<ListPokemonModel> listPokemonCaught =
            state.dataPokemonList.listPokemon.where((element) {
          return element.isCaught == true;
        }).toList();
        emit(PokemonListSuccess(
            dataPokemonList: state.dataPokemonList,
            dataPokemonListCaught: listPokemonCaught));
      }
    });
  }
}
