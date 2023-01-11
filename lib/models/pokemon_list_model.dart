class PokemonInfoPage {
  final int count;
  final String? next;
  final String? previous;

  const PokemonInfoPage({required this.count, this.next, this.previous});

  factory PokemonInfoPage.fromJson(Map<String, dynamic> json) {
    return PokemonInfoPage(
        count: json['count'], next: json['next'], previous: json['previous']);
  }
}

class ListPokemon {
  final String name;
  final String url;
  final String id;

  ListPokemon({required this.name, required this.url, required this.id});

  factory ListPokemon.fromJson(Map<String, dynamic> json) {
    var splitItem = json['url'].toString().split("/");
    return ListPokemon(
        name: json['name'],
        url: json['url'],
        id: splitItem[splitItem.length - 2]);
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
