import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/gen/assets.gen.dart';
import 'package:flutter_pokemon_app/gen/colors.gen.dart';

enum PokemonType {
  bug,
  dark,
  dragon,
  electric,
  fairy,
  fighting,
  fire,
  flying,
  ghost,
  grass,
  ground,
  icy,
  normal,
  poison,
  psychic,
  rock,
  steel,
  water,
}

extension PokemonTypeExtension on PokemonType {
  PokemonType getTypeBy(String name) {
    return PokemonTypeExtension.pokemonType[name] ?? PokemonType.bug;
  }

  static Map<String, PokemonType> pokemonType = {
    "bug": PokemonType.bug,
    "dark": PokemonType.dark,
    "dragon": PokemonType.dragon,
    "electric": PokemonType.electric,
    "fairy": PokemonType.fairy,
    "fighting": PokemonType.fighting,
    "fire": PokemonType.fire,
    "flying": PokemonType.flying,
    "ghost": PokemonType.ghost,
    "grass": PokemonType.grass,
    "ground": PokemonType.ground,
    "icy": PokemonType.icy,
    "normal": PokemonType.normal,
    "poison": PokemonType.poison,
    "psychic": PokemonType.psychic,
    "rock": PokemonType.rock,
    "steel": PokemonType.steel,
    "water": PokemonType.water
  };

  Image image() {
    switch (this) {
      case PokemonType.bug:
        return Assets.images.pokemonTypeIcons.bug.image();
      case PokemonType.dark:
        return Assets.images.pokemonTypeIcons.dark.image();
      case PokemonType.dragon:
        return Assets.images.pokemonTypeIcons.dragon.image();
      case PokemonType.electric:
        return Assets.images.pokemonTypeIcons.electric.image();
      case PokemonType.fairy:
        return Assets.images.pokemonTypeIcons.fairy.image();
      case PokemonType.fighting:
        return Assets.images.pokemonTypeIcons.fighting.image();
      case PokemonType.fire:
        return Assets.images.pokemonTypeIcons.fire.image();
      case PokemonType.flying:
        return Assets.images.pokemonTypeIcons.flying.image();
      case PokemonType.ghost:
        return Assets.images.pokemonTypeIcons.ghost.image();
      case PokemonType.grass:
        return Assets.images.pokemonTypeIcons.grass.image();
      case PokemonType.ground:
        return Assets.images.pokemonTypeIcons.ground.image();
      case PokemonType.icy:
        return Assets.images.pokemonTypeIcons.icy.image();
      case PokemonType.normal:
        return Assets.images.pokemonTypeIcons.normal.image();
      case PokemonType.poison:
        return Assets.images.pokemonTypeIcons.poison.image();
      case PokemonType.psychic:
        return Assets.images.pokemonTypeIcons.psychic.image();
      case PokemonType.rock:
        return Assets.images.pokemonTypeIcons.rock.image();
      case PokemonType.steel:
        return Assets.images.pokemonTypeIcons.steel.image();
      case PokemonType.water:
        return Assets.images.pokemonTypeIcons.water.image();
    }
  }

  Color mainColor() {
    switch (this) {
      case PokemonType.bug:
        return PokemonTypeColors.mainBug;
      case PokemonType.dark:
        return PokemonTypeColors.mainDark;
      case PokemonType.dragon:
        return PokemonTypeColors.mainDragon;
      case PokemonType.electric:
        return PokemonTypeColors.mainElectric;
      case PokemonType.fairy:
        return PokemonTypeColors.mainFairy;
      case PokemonType.fighting:
        return PokemonTypeColors.mainFighting;
      case PokemonType.fire:
        return PokemonTypeColors.mainFire;
      case PokemonType.flying:
        return PokemonTypeColors.mainFlying;
      case PokemonType.ghost:
        return PokemonTypeColors.mainGhost;
      case PokemonType.grass:
        return PokemonTypeColors.mainGrass;
      case PokemonType.ground:
        return PokemonTypeColors.mainGround;
      case PokemonType.icy:
        return PokemonTypeColors.mainIcy;
      case PokemonType.normal:
        return PokemonTypeColors.mainNormal;
      case PokemonType.poison:
        return PokemonTypeColors.mainPoison;
      case PokemonType.psychic:
        return PokemonTypeColors.mainPsychic;
      case PokemonType.rock:
        return PokemonTypeColors.mainRock;
      case PokemonType.steel:
        return PokemonTypeColors.mainSteel;
      case PokemonType.water:
        return PokemonTypeColors.mainWater;
    }
  }

  Color backgroundColor() {
    switch (this) {
      case PokemonType.bug:
        return PokemonTypeColors.bgBug;
      case PokemonType.dark:
        return PokemonTypeColors.bgDark;
      case PokemonType.dragon:
        return PokemonTypeColors.bgDragon;
      case PokemonType.electric:
        return PokemonTypeColors.bgElectric;
      case PokemonType.fairy:
        return PokemonTypeColors.bgFairy;
      case PokemonType.fighting:
        return PokemonTypeColors.bgFighting;
      case PokemonType.fire:
        return PokemonTypeColors.bgFire;
      case PokemonType.flying:
        return PokemonTypeColors.bgFlying;
      case PokemonType.ghost:
        return PokemonTypeColors.bgGhost;
      case PokemonType.grass:
        return PokemonTypeColors.bgGrass;
      case PokemonType.ground:
        return PokemonTypeColors.bgGround;
      case PokemonType.icy:
        return PokemonTypeColors.bgIcy;
      case PokemonType.normal:
        return PokemonTypeColors.bgNormal;
      case PokemonType.poison:
        return PokemonTypeColors.bgPoison;
      case PokemonType.psychic:
        return PokemonTypeColors.bgPsychic;
      case PokemonType.rock:
        return PokemonTypeColors.bgRock;
      case PokemonType.steel:
        return PokemonTypeColors.bgSteel;
      case PokemonType.water:
        return PokemonTypeColors.bgWater;
    }
  }
}

class ChipModel {
  String title = '';
  Image? image;
  Color? textColor;
  Color? backgroundColor;

  ChipModel({required this.title, this.textColor, this.backgroundColor});

  void fillWith(PokemonType type) {
    this.title = type.name;
    this.image = type.image();
    this.textColor = type.mainColor();
    this.backgroundColor = type.backgroundColor();
  }

  void fillWithPokemonName(String name) {
    final type = PokemonTypeExtension.pokemonType[name] ?? PokemonType.bug;

    this.title = type.name.capitalizeFirst();
    this.image = type.image();
    this.textColor = type.mainColor();
    this.backgroundColor = type.backgroundColor();
  }

  void fill(
      String title, Image? image, Color? textColor, Color? backgroundColor) {
    this.title = title.capitalizeFirst();
    this.image = image;
    this.textColor = textColor;
    this.backgroundColor = backgroundColor;
  }
}
