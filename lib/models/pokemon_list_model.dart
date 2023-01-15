class PokemonListModel {
  final int count;
  final String? next;
  final String? previous;

  // list
  final List<ListPokemonModel> listPokemon;

  const PokemonListModel(
      {required this.count,
      this.next,
      this.previous,
      required this.listPokemon});

  factory PokemonListModel.fromJson(Map<String, dynamic> json) {
    return PokemonListModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        listPokemon: List<Map<String, dynamic>>.from(json['results'])
            .map((e) => ListPokemonModel.fromJson(e))
            .toList());
  }
}

class ListPokemonModel {
  final String name;
  final String url;
  final String id;
  final bool? isCaught;

  ListPokemonModel(
      {required this.name, required this.url, required this.id, this.isCaught});

  factory ListPokemonModel.fromJson(Map<String, dynamic> json) {
    var splitItem = json['url'].toString().split("/");
    return ListPokemonModel(
        name: json['name'],
        url: json['url'],
        id: splitItem[splitItem.length - 2],
        isCaught: false);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    var splitItem = data['url'].toString().split("/");
    data['name'] = name;
    data['url'] = url;
    data['id'] = splitItem[splitItem.length - 2];
    return data;
  }
}
