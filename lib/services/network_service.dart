import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:http/http.dart' as http;


class NetworkService {
  var authority = 'pokeapi.co';
  var path = '/api/v2/pokemon/';

  Future<PokemonList> getPokemonList() async {
    var url = Uri.https(authority, path, {'limit': '20', 'offset': '20'});
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return PokemonList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }

  Future<FullPokemon> getFullPokemon(String stringUrl) async {
    var url = Uri.parse(stringUrl);
    final response = await http.get(url);
    if(response.statusCode == 200) {
      return FullPokemon.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}

