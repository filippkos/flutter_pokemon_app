import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/services/networking/network_service.dart';
import 'package:flutter_pokemon_app/services/networking/pokemon_provider.dart';
import 'package:flutter_pokemon_app/services/pagination/page_service.dart';

class Pagination {
  PageService _pageService = PageService();
  PokemonProviderInterface _pokemonProvider = PokemonProvider(
    networkService: NetworkService(),
    authority: 'pokeapi.co',
    path: '/api/v2/pokemon/',
  );

  List<ListPokemon> _allShortPokemonList = [];
  List<ListPokemon> _filteredShortPokemonList = [];

  int currentLimit = 0;
  int currentOffset = 0;
  String? currentFilter;
  List<ListPokemon> currentList = [];

  Future<PokemonList> loadBaseModel() async {
    PokemonList list;
    list = await _pokemonProvider.getPokemonList(800, '0');

    return list;
  }

  Future<void> prepareAllShortList() async {
    await loadBaseModel().then((value) {
      value.results.forEach((element) {
        _allShortPokemonList.add(element);
      });
    });
  }

  Future<List<FullPokemon>> getPage(
      String? filter, int limit, int offset) async {
    List<String> urls = [];
    if (filter == null) {
      currentList = _allShortPokemonList;
    } else {
      if (filter != currentFilter) {
        await updateFilteredShortPokemonlist(filter);
        currentFilter = filter;
      }
      currentList = _filteredShortPokemonList;
    }

    updateLimitAndOffset(currentList, limit, offset);

    urls = currentList
        .sublist(currentOffset, currentLimit)
        .map((e) => e.url)
        .toList();

    return _pageService.page(urls);
  }

  Future<void> updateFilteredShortPokemonlist(String filter) async {
    _filteredShortPokemonList.clear();
    await Future.forEach(_allShortPokemonList, (pokemon) {
      if (pokemon.name.startsWith(filter)) {
        _filteredShortPokemonList.add(pokemon);
      }
    });
  }

  Future<void> updateLimitAndOffset(
      List<ListPokemon> list, int limit, int offset) async {
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

    if (list.length < offset + limit) {
      currentLimit = list.length;
      currentOffset = offset;
    }

    if (list.length == offset) {
      currentLimit = currentOffset;
    }
  }
}
