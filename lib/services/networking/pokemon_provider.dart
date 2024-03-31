import 'dart:convert';

import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/services/networking/network_service.dart';

abstract interface class PokemonProvidable {

  NetworkService get networkService;
  
  String get authority;
  String get path;

  Future<PokemonList> getPokemonList(int limit, String offset);
  Future<FullPokemon> getFullPokemon(String stringUrl);
}

class PokemonProvider implements PokemonProvidable {

  @override
  final NetworkService networkService = NetworkService();

  @override
  final authority = 'pokeapi.co';

  @override
  final path = '/api/v2/pokemon/';

  @override
  Future<PokemonList> getPokemonList(int limit, String offset) async {
    var uri = Uri.https(authority, path, {'limit': '${limit}', 'offset': '${offset}'});
    final response = await networkService.uriRequest(uri);
    if (response.statusCode == 200) {
      return PokemonList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Future<FullPokemon> getFullPokemon(String stringUrl) async {
    final response = await networkService.request(stringUrl);
    if(response.statusCode == 200) {
      return FullPokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}