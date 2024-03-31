import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/services/networking/pokemon_provider.dart';
import 'package:flutter_pokemon_app/services/pagination/page_service.dart';

class Pagination {

  PageService pageService = PageService();
  PokemonProvider pokemonProvider = PokemonProvider();

  List<ListPokemon> allShortPokemonList = [];
  List<ListPokemon> filteredShortPokemonList = [];

  int currentLimit = 0;
  int currentOffset = 0;
  String? currentFilter;
  List<ListPokemon> currentList = [];

  Future<PokemonList> loadBaseModel() async {
    PokemonList list;
    list = await pokemonProvider.getPokemonList(800, '0');
    
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
      currentList = allShortPokemonList;
    } else {
      if (filter != currentFilter) {
        await updateFilteredShortPokemonlist(filter);
        currentFilter = filter;
      }
      currentList = filteredShortPokemonList;
    }
    
    updateLimitAndOffset(currentList, limit, offset);
    
    urls = currentList.sublist(currentOffset, currentLimit).map((e) => e.url).toList();

    return pageService.page(urls);
  }

  Future<void> updateFilteredShortPokemonlist(String filter) async {
    filteredShortPokemonList.clear();
    await Future.forEach(allShortPokemonList, (pokemon) {
        if (pokemon.name.startsWith(filter)) {
          filteredShortPokemonList.add(pokemon);
        }
    });
  }

  Future<void> updateLimitAndOffset(List<ListPokemon> list, int limit, int offset) async {
    if (list.length >= offset + limit) {
      currentLimit = limit;
      currentOffset = offset;
    }

    if (list.length > offset && list.length < offset + limit) {
      currentLimit = list.length - offset;
      currentOffset = offset;
    }

    if (list.length > offset + limit) {
      currentLimit = limit;
      currentOffset = offset;
    }

    if(list.length < offset + limit) {
      currentLimit = list.length;
      currentOffset = offset;
    }

    if (list.length == offset) {
      currentLimit = currentOffset;
    }
  }
}