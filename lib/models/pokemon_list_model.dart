class PokemonList {
    int count;
    String next;
    String? previous;
    List<ListPokemon> results;

    PokemonList({
        required this.count,
        required this.next,
        required this.previous,
        required this.results,
    });

    factory PokemonList.fromJson(Map<String, dynamic> json) {
      var resultsJson = json['results'] as List;

      List<ListPokemon> pokemonList = resultsJson.map((i) => ListPokemon.fromJson(i)).toList();

      return PokemonList(
        count: json['count'] as int, 
        next: json['next'] as String, 
        previous: json['previous'] as String?, 
        results: pokemonList
      );
    }
}

class ListPokemon {
    final String name;
    final String url;

    ListPokemon({
        required this.name,
        required this.url,
    });

    factory ListPokemon.fromJson(Map<String, dynamic> json) {
      
      return ListPokemon(
        name: json['name'] as String, 
        url: json['url'] as String
      );
    }
}