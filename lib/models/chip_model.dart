import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';

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
  water
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
        return Image(image: AssetImage('assets/images/pokemon_type_icons/bug.png'));
      case PokemonType.dark:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/dark.png'));
      case PokemonType.dragon:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/dragon.png'));
      case PokemonType.electric:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/electric.png'));
      case PokemonType.fairy:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/fairy.png'));
      case PokemonType.fighting:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/fighting.png'));
      case PokemonType.fire:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/fire.png'));
      case PokemonType.flying:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/flying.png'));
      case PokemonType.ghost:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/ghost.png'));
      case PokemonType.grass:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/grass.png'));
      case PokemonType.ground:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/ground.png'));
      case PokemonType.icy:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/icy.png'));
      case PokemonType.normal:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/normal.png'));
      case PokemonType.poison:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/poison.png'));
      case PokemonType.psychic:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/psychic.png'));
      case PokemonType.rock:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/rock.png'));
      case PokemonType.steel:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/steel.png'));
      case PokemonType.water:
        return Image(image: AssetImage('assets/images/pokemon_type_icons/water.png'));
    }
  }

Color mainColor() {
    switch (this) {
      case PokemonType.bug:
        return PokemonTypeMainColors.bug;
      case PokemonType.dark:
        return PokemonTypeMainColors.dark;
      case PokemonType.dragon:
        return PokemonTypeMainColors.dragon;
      case PokemonType.electric:
        return PokemonTypeMainColors.electric;
      case PokemonType.fairy:
        return PokemonTypeMainColors.fairy;
      case PokemonType.fighting:
        return PokemonTypeMainColors.fighting;
      case PokemonType.fire:
        return PokemonTypeMainColors.fire;
      case PokemonType.flying:
        return PokemonTypeMainColors.flying;
      case PokemonType.ghost:
        return PokemonTypeMainColors.ghost;
      case PokemonType.grass:
        return PokemonTypeMainColors.grass;
      case PokemonType.ground:
        return PokemonTypeMainColors.ground;
      case PokemonType.icy:
        return PokemonTypeMainColors.icy;
      case PokemonType.normal:
        return PokemonTypeMainColors.normal;
      case PokemonType.poison:
        return PokemonTypeMainColors.poison;
      case PokemonType.psychic:
        return PokemonTypeMainColors.psychic;
      case PokemonType.rock:
        return PokemonTypeMainColors.rock;
      case PokemonType.steel:
        return PokemonTypeMainColors.steel;
      case PokemonType.water:
        return PokemonTypeMainColors.water;
    }
  }

 Color backgroundColor() {
    switch (this) {
      case PokemonType.bug:
        return PokemonTypeBGColors.bug;
      case PokemonType.dark:
        return PokemonTypeBGColors.dark;
      case PokemonType.dragon:
        return PokemonTypeBGColors.dragon;
      case PokemonType.electric:
        return PokemonTypeBGColors.electric;
      case PokemonType.fairy:
        return PokemonTypeBGColors.fairy;
      case PokemonType.fighting:
        return PokemonTypeBGColors.fighting;
      case PokemonType.fire:
        return PokemonTypeBGColors.fire;
      case PokemonType.flying:
        return PokemonTypeBGColors.flying;
      case PokemonType.ghost:
        return PokemonTypeBGColors.ghost;
      case PokemonType.grass:
        return PokemonTypeBGColors.grass;
      case PokemonType.ground:
        return PokemonTypeBGColors.ground;
      case PokemonType.icy:
        return PokemonTypeBGColors.icy;
      case PokemonType.normal:
        return PokemonTypeBGColors.normal;
      case PokemonType.poison:
        return PokemonTypeBGColors.poison;
      case PokemonType.psychic:
        return PokemonTypeBGColors.psychic;
      case PokemonType.rock:
        return PokemonTypeBGColors.rock;
      case PokemonType.steel:
        return PokemonTypeBGColors.steel;
      case PokemonType.water:
        return PokemonTypeBGColors.water;
    }
  }
}

class ChipModel {
  String title = '';
  Image? image;
  Color? textColor = Colors.black;
  Color? backgroundColor = ColorConstants.wildSand;

  ChipModel({required this.title});

  void fillWith(PokemonType type) {
    this.title = type.name;
    this.image = type.image();
    this.textColor = type.mainColor();
    this.backgroundColor = type.backgroundColor();
  }

  void fillWithPokemonName(String name) {
    final type = PokemonTypeExtension.pokemonType[name] ?? PokemonType.bug;

    this.title = type.name;
    this.image = type.image();
    this.textColor = type.mainColor();
    this.backgroundColor = type.backgroundColor();
  }

  void fill(String title, Image? image, Color? textColor, Color? backgroundColor) {
    this.title = title;
    this.image = image;
    this.textColor = textColor;
    this.backgroundColor = backgroundColor;
  }
}