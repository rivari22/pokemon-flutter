import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:pokedex/constants/index.dart';
import 'package:pokedex/models/pokemon_detail_model.dart';

Future<PokemonDetailModel> fetchPokemonDetail(String id) async {
  final response = await http.get(Uri.parse("${urlPokemon}pokemon/$id"));

  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    return PokemonDetailModel.fromJson(res);
  } else {
    throw Exception('Failed to load album');
  }
}
