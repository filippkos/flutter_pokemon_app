import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/networking/network_service.dart';
import 'package:flutter_pokemon_app/services/networking/pokemon_provider.dart';

class PageService {
  
  PokemonProviderInterface pokemonProvider = PokemonProvider(networkService: NetworkService(), authority: 'pokeapi.co', path: '/api/v2/pokemon/');
  List<FullPokemon> list = [];

  Future<List<FullPokemon>> page(List<String> urls) async {
    await Future.forEach(urls, (url) async {
      final pokemon = await pokemonProvider.getFullPokemon(url);
      list.add(pokemon);
    });
    return list;
  }
}