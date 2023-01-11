import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:pokedex/constants/index.dart';

import '../models/pokemon_list_model.dart';

Future<List<ListPokemon>> fetchPokemons() async {
  final response =
      await http.get(Uri.parse("${urlPokemon}pokemon/?limit=20&offset=0"));

  if (response.statusCode == 200) {
    Map<String, dynamic> res = jsonDecode(response.body);
    Iterable result = res['results'];
    return result.map((e) => ListPokemon.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}
