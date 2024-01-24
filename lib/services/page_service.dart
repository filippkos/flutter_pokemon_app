
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';

class PageService {
  NetworkService networkService = NetworkService();
  List<FullPokemon> list = [];

  Future<List<FullPokemon>> page(List<String> urls) async {
    await Future.forEach(urls, (url) async {
      final pokemon = await networkService.getFullPokemon(url);
      list.add(pokemon);
    });
    return list;
  }
}