import 'package:flutter/material.dart';

class FullPokemon {
    // List<Ability> abilities;
    int baseExperience;
    // List<Species> forms;
    // List<GameIndex> gameIndices;
    int height;
    // List<HeldItem> heldItems;
    int id;
    bool isDefault;
    String locationAreaEncounters;
    // List<Move> moves;
    String name;
    int order;
    // List<dynamic> pastAbilities;
    // List<dynamic> pastTypes;
    Species species;
    Sprites sprites;
    // List<Stat> stats;
    // List<Type> types;
    int weight;

    FullPokemon({
        // required this.abilities,
        required this.baseExperience,
        // required this.forms,
        // required this.gameIndices,
        required this.height,
        // required this.heldItems,
        required this.id,
        required this.isDefault,
        required this.locationAreaEncounters,
        // required this.moves,
        required this.name,
        required this.order,
        // required this.pastAbilities,
        // required this.pastTypes,
        required this.species,
        required this.sprites,
        // required this.stats,
        // required this.types,
        required this.weight,
    });

    factory FullPokemon.fromJson(Map<String, dynamic> json) {

      var speciesJson = json['species'];
      var spritesJson = json['sprites'];

      Species species = Species.fromJson(speciesJson);
      Sprites sprites = Sprites.fromJson(spritesJson);

      return FullPokemon(
        baseExperience: json['base_experience'] as int, 
        height: json['height'] as int, 
        id: json['id'] as int, 
        isDefault: json['is_default'] as bool, 
        locationAreaEncounters: json['location_area_encounters'] as String, 
        name: json['name'] as String, 
        order: json['order'] as int, 
        species: species, 
        sprites: sprites, 
        weight: json['weight'] as int
        );
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
      return Species(
        name: json['name'] as String, 
        url: json['url'] as String
      );
    }
}

class Sprites {
    final String backDefault;
    // dynamic backFemale;
    final String backShiny;
    // dynamic backShinyFemale;
    final String frontDefault;
    // dynamic frontFemale;
    final String frontShiny;
    // dynamic frontShinyFemale;
    // Other? other;
    // Versions? versions;
    // Sprites? animated;

    Sprites({
        required this.backDefault,
        // required this.backFemale,
        required this.backShiny,
        // required this.backShinyFemale,
        required this.frontDefault,
        // required this.frontFemale,
        required this.frontShiny,
        // required this.frontShinyFemale,
        // this.other,
        // this.versions,
        // this.animated,
    });

    factory Sprites.fromJson(Map<String, dynamic> json) {
      return Sprites(
        backDefault: json['back_default'] as String, 
        backShiny: json['back_shiny'] as String, 
        frontDefault: json['front_default'] as String, 
        frontShiny: json['front_shiny'] as String
      );
    }
}

// class Ability {
//     Species ability;
//     bool isHidden;
//     int slot;

//     Ability({
//         required this.ability,
//         required this.isHidden,
//         required this.slot,
//     });

// }

// class GameIndex {
//     int gameIndex;
//     Species version;

//     GameIndex({
//         required this.gameIndex,
//         required this.version,
//     });

// }

// class HeldItem {
//     Species item;
//     List<VersionDetail> versionDetails;

//     HeldItem({
//         required this.item,
//         required this.versionDetails,
//     });

// }

// class VersionDetail {
//     int rarity;
//     Species version;

//     VersionDetail({
//         required this.rarity,
//         required this.version,
//     });

// }

// class Move {
//     Species move;
//     List<VersionGroupDetail> versionGroupDetails;

//     Move({
//         required this.move,
//         required this.versionGroupDetails,
//     });

// }

// class VersionGroupDetail {
//     int levelLearnedAt;
//     Species moveLearnMethod;
//     Species versionGroup;

//     VersionGroupDetail({
//         required this.levelLearnedAt,
//         required this.moveLearnMethod,
//         required this.versionGroup,
//     });

// }

// class GenerationV {
//     Sprites blackWhite;

//     GenerationV({
//         required this.blackWhite,
//     });

// }

// class GenerationIv {
//     Sprites diamondPearl;
//     Sprites heartgoldSoulsilver;
//     Sprites platinum;

//     GenerationIv({
//         required this.diamondPearl,
//         required this.heartgoldSoulsilver,
//         required this.platinum,
//     });

// }

// class Versions {
//     GenerationI generationI;
//     GenerationIi generationIi;
//     GenerationIii generationIii;
//     GenerationIv generationIv;
//     GenerationV generationV;
//     Map<String, Home> generationVi;
//     GenerationVii generationVii;
//     GenerationViii generationViii;

//     Versions({
//         required this.generationI,
//         required this.generationIi,
//         required this.generationIii,
//         required this.generationIv,
//         required this.generationV,
//         required this.generationVi,
//         required this.generationVii,
//         required this.generationViii,
//     });

// }

// class GenerationI {
//     RedBlue redBlue;
//     RedBlue yellow;

//     GenerationI({
//         required this.redBlue,
//         required this.yellow,
//     });

// }

// class RedBlue {
//     String backDefault;
//     String backGray;
//     String backTransparent;
//     String frontDefault;
//     String frontGray;
//     String frontTransparent;

//     RedBlue({
//         required this.backDefault,
//         required this.backGray,
//         required this.backTransparent,
//         required this.frontDefault,
//         required this.frontGray,
//         required this.frontTransparent,
//     });

// }

// class GenerationIi {
//     Crystal crystal;
//     Gold gold;
//     Gold silver;

//     GenerationIi({
//         required this.crystal,
//         required this.gold,
//         required this.silver,
//     });

// }

// class Crystal {
//     String backDefault;
//     String backShiny;
//     String backShinyTransparent;
//     String backTransparent;
//     String frontDefault;
//     String frontShiny;
//     String frontShinyTransparent;
//     String frontTransparent;

//     Crystal({
//         required this.backDefault,
//         required this.backShiny,
//         required this.backShinyTransparent,
//         required this.backTransparent,
//         required this.frontDefault,
//         required this.frontShiny,
//         required this.frontShinyTransparent,
//         required this.frontTransparent,
//     });

// }

// class Gold {
//     String backDefault;
//     String backShiny;
//     String frontDefault;
//     String frontShiny;
//     String? frontTransparent;

//     Gold({
//         required this.backDefault,
//         required this.backShiny,
//         required this.frontDefault,
//         required this.frontShiny,
//         this.frontTransparent,
//     });

// }

// class GenerationIii {
//     OfficialArtwork emerald;
//     Gold fireredLeafgreen;
//     Gold rubySapphire;

//     GenerationIii({
//         required this.emerald,
//         required this.fireredLeafgreen,
//         required this.rubySapphire,
//     });

// }

// class OfficialArtwork {
//     String frontDefault;
//     String frontShiny;

//     OfficialArtwork({
//         required this.frontDefault,
//         required this.frontShiny,
//     });

// }

// class Home {
//     String frontDefault;
//     dynamic frontFemale;
//     String frontShiny;
//     dynamic frontShinyFemale;

//     Home({
//         required this.frontDefault,
//         required this.frontFemale,
//         required this.frontShiny,
//         required this.frontShinyFemale,
//     });

// }

// class GenerationVii {
//     DreamWorld icons;
//     Home ultraSunUltraMoon;

//     GenerationVii({
//         required this.icons,
//         required this.ultraSunUltraMoon,
//     });

// }

// class DreamWorld {
//     String frontDefault;
//     dynamic frontFemale;

//     DreamWorld({
//         required this.frontDefault,
//         required this.frontFemale,
//     });

// }

// class GenerationViii {
//     DreamWorld icons;

//     GenerationViii({
//         required this.icons,
//     });

// }

// class Other {
//     DreamWorld dreamWorld;
//     Home home;
//     OfficialArtwork officialArtwork;

//     Other({
//         required this.dreamWorld,
//         required this.home,
//         required this.officialArtwork,
//     });

// }

// class Stat {
//     int baseStat;
//     int effort;
//     Species stat;

//     Stat({
//         required this.baseStat,
//         required this.effort,
//         required this.stat,
//     });

// }

// class Type {
//     int slot;
//     Species type;

//     Type({
//         required this.slot,
//         required this.type,
//     });

// }
