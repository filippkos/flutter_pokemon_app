import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';
import 'package:flutter_pokemon_app/services/page_service.dart';

class Pagination {

  PageService pageService = PageService();
  NetworkService networkService = NetworkService();

  List<ListPokemon> allShortPokemonList = [];
  List<ListPokemon> filteredShortPokemonList = [];

  Future<PokemonList> loadBaseModel() async {
    PokemonList list;
    list = await networkService.getPokemonList(800, '0');
    
    return list;
  }

  Future<void> prepareAllShortList() async {
    await loadBaseModel().then((value) {
      value.results.forEach((element) { 
        
        allShortPokemonList.add(element);
      });
    });
  }

  Future<List<FullPokemon>> getPage(String? filter, int limit, int offset) async {
    List<String> urls = [];
    if (filter == null) {
      urls = allShortPokemonList.sublist(offset, limit).map((e) => e.url).toList();
    } else {
      await updateFilteredShortPokemonlist(filter);
      urls = filteredShortPokemonList.sublist(offset, limit).map((e) => e.url).toList();
    }

    return pageService.page(urls);
  }

  Future<void> updateFilteredShortPokemonlist(String filter) async {
    await Future.forEach(allShortPokemonList, (pokemon) {
        if (pokemon.name.contains(filter)) {
          filteredShortPokemonList.add(pokemon);
        }
    });
  }

}