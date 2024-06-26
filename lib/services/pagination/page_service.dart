import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/networking/network_service.dart';
import 'package:flutter_pokemon_app/services/networking/pokemon_provider.dart';

class PageService {
  PokemonProviderInterface pokemonProvider = PokemonProvider(
    networkService: NetworkService(),
    authority: 'pokeapi.co',
    path: '/api/v2/pokemon/',
  );
  List<FullPokemon> _list = [];

  Future<List<FullPokemon>> page(List<String> urls) async {
    await Future.wait(urls.map((url) async {
      final pokemon = await pokemonProvider.getFullPokemon(url);
      _list.add(pokemon);
    }));
    _list.sort((a,b) => a.id.compareTo(b.id));;

    return _list;
  }
}