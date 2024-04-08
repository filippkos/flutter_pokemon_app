class FullPokemon {
  List<Ability> abilities;
  int baseExperience;
  List<Species> forms;
  int height;
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<Move> moves;
  String name;
  int order;
  Species species;
  Sprites sprites;
  List<Type> types;
  int weight;

  FullPokemon({
    required this.abilities,
    required this.baseExperience,
    required this.forms,
    required this.height,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.species,
    required this.sprites,
    required this.types,
    required this.weight,
  });

  factory FullPokemon.fromJson(Map<String, dynamic> json) {
    var speciesJson = json['species'];
    var spritesJson = json['sprites'];
    var typesJson = json['types'] as List;
    var abilitiesJson = json['abilities'] as List;
    var formsJson = json['forms'] as List;
    var movesJson = json['moves'] as List;

    Species species = Species.fromJson(speciesJson);
    Sprites sprites = Sprites.fromJson(spritesJson);
    List<Type> types = typesJson.map((i) => Type.fromJson(i)).toList();
    List<Ability> abilities =
        abilitiesJson.map((i) => Ability.fromJson(i)).toList();
    List<Species> forms = formsJson.map((i) => Species.fromJson(i)).toList();
    List<Move> moves = movesJson.map((i) => Move.fromJson(i)).toList();

    return FullPokemon(
        abilities: abilities,
        baseExperience: json['base_experience'] as int,
        forms: forms,
        height: json['height'] as int,
        id: json['id'] as int,
        isDefault: json['is_default'] as bool,
        locationAreaEncounters: json['location_area_encounters'] as String,
        moves: moves,
        name: json['name'] as String,
        order: json['order'] as int,
        species: species,
        sprites: sprites,
        weight: json['weight'] as int,
        types: types);
  }
}

class Move {
  Species move;

  Move({
    required this.move,
  });

  factory Move.fromJson(Map<String, dynamic> json) {
    var moveJson = json['move'];

    Species species = Species.fromJson(moveJson);

    return Move(move: species);
  }
}

class Ability {
  Species ability;
  bool isHidden;
  int slot;

  Ability({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    var abilityJson = json['ability'];

    Species species = Species.fromJson(abilityJson);

    return Ability(
        ability: species,
        isHidden: json['is_hidden'] as bool,
        slot: json['slot'] as int);
  }
}

class Type {
  int slot;
  Species type;

  Type({
    required this.slot,
    required this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) {
    var typeJson = json['type'];

    Species type = Species.fromJson(typeJson);

    return Type(slot: json['slot'] as int, type: type);
  }
}

class Species {
  final String name;
  final String url;

  Species({
    required this.name,
    required this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) {
    return Species(name: json['name'] as String, url: json['url'] as String);
  }
}

class Sprites {
  final String? frontDefault;

  Sprites({
    required this.frontDefault,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) {
    return Sprites(frontDefault: json['front_default'] as String);
  }
}
