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
      emit(PokemonListSuccess(response));
      // emit(ProductSuccess(products: productFromJson(response.body)));
    });
  }
}
