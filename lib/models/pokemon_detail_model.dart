class InfoPokemonDetail {
  final int id;
  final String name;
  final int height;
  final int weight;
  final int baseExperience;

  // list
  final List<Abilities> abilities;
  final List<Types> types;
  final List<Stats> stats;

  const InfoPokemonDetail(
      {required this.id,
      required this.name,
      required this.weight,
      required this.height,
      required this.baseExperience,
      required this.abilities,
      required this.types,
      required this.stats});

  factory InfoPokemonDetail.fromJson(Map<String, dynamic> json) {
    return InfoPokemonDetail(
      name: json['name'],
      id: json['id'],
      height: json['height'],
      weight: json['weight'],
      baseExperience: json['base_experience'],
      abilities: List<Map<String, dynamic>>.from(json['abilities'])
          .map((e) => Abilities.fromJson(e))
          .toList(),
      types: List<Map<String, dynamic>>.from(json['types'])
          .map((e) => Types.fromJson(e))
          .toList(),
      stats: List<Map<String, dynamic>>.from(json['stats'])
          .map((e) => Stats.fromJson(e))
          .toList(),
    );
  }
}

class Stats {
  final int baseStat;
  final int effort;
  final String baseName;

  const Stats(
      {required this.baseStat, required this.effort, required this.baseName});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
        baseName: json['stat']['name'],
        effort: json['effort'],
        baseStat: json['base_stat']);
  }
}

class Types {
  final String typeName;

  const Types({required this.typeName});

  factory Types.fromJson(Map<String, dynamic> json) {
    return Types(
      typeName: json['type']['name'],
    );
  }
}

class Abilities {
  final String abilityName;

  const Abilities({required this.abilityName});

  factory Abilities.fromJson(Map<String, dynamic> json) {
    return Abilities(
      abilityName: json['ability']['name'],
    );
  }
}
