import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/repository/pokemon_list_future.dart';
import '../../models/pokemon_list_model.dart';

part 'pokemon_list_event.dart';
part 'pokemon_list_state.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc() : super(PokemonListInitial()) {
    on<GetPokemonListEvent>((event, emit) async {
      emit(PokemonListLoading());
      final response = await fetchPokemons();
      emit(PokemonListSuccess(
          dataPokemonList: response, dataPokemonListCaught: []));
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
