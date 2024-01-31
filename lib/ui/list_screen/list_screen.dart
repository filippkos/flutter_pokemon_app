import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/debouncer.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';
import 'package:flutter_pokemon_app/services/pagination.dart';
import 'package:flutter_pokemon_app/ui/list_screen/single_column_cell.dart';
import 'package:flutter_pokemon_app/ui/list_screen/twin_column_cell.dart';
import 'package:flutter_pokemon_app/ui/views/pokeball_spinner.dart';
import 'package:flutter_pokemon_app/ui/views/search_field.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final NetworkService networkService = NetworkService();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  final Pagination paginationService = Pagination();
  StreamController<bool> _searchBarController = StreamController<bool>();
  final _searchDebouncer = Debouncer(milliseconds: 1000);
  SearchField? _searchField;

  List<FullPokemon> _commonFullPokemonList = [];
  var _streamController = new StreamController<List<FullPokemon>>();

  var _isGridEnabled = false;
  var _isLoading = false;
  dynamic appBarRightIcon = Icons.grid_view;
  String? filter;
  int page = 10;
  int limit = 10;
  int offset = 0;

  @override
  void dispose() {
    _streamController.close();
    _scrollController.dispose();
    _textEditingController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _searchField = SearchField(pullToRefreshCallback: pullToRefresh, textEditingController: _textEditingController, stream: _searchBarController.stream);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        loadPokemons(filter);
      }
    });

    _textEditingController.addListener(() {
      _searchDebouncer.run(() {
        String? text = _textEditingController.text;
        text = text.isEmpty ? null : text;
        if (text != null) {
          _searchBarController.add(true);
        }
        if (text != filter) {
          filter = text;
          resetData();
          loadPokemons(filter);
        }
      });
    });

    loadingInit();
  }

  resetData() {
    limit = page;
    offset = 0;
    _commonFullPokemonList.clear();
    _streamController.add(_commonFullPokemonList);
  }

  loadingInit() async {
    await paginationService.prepareAllShortList();
    loadPokemons(filter);
  }

  loadPokemons(String? filter) async {
    _isLoading = true;
    _commonFullPokemonList = await paginationService.getPage(
      filter, 
      limit, 
      _commonFullPokemonList.length
    );
    _streamController.add(_commonFullPokemonList);
    limit += page;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.wildSand,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                appBarRightIcon,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isGridEnabled = !_isGridEnabled;
                  if (_isGridEnabled == true) {
                    appBarRightIcon = Icons.view_agenda_outlined;
                  } else {
                    appBarRightIcon = Icons.grid_view;
                  }
                });
              },
            ),
          ],
          surfaceTintColor: ColorConstants.wildSand,
          title: const Text(
            'All pokemon',
            style: TextStyle(
                fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.bold),
          ),
          backgroundColor: ColorConstants.wildSand,
          leading: IconButton(
              padding: EdgeInsets.all(15),
              onPressed: () => Navigator.pop(context),
              icon: Image.asset('assets/images/app_icon/android.png')),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [
            _searchField!,
            Expanded(child: bodyView())
          ],
        ));
  }

  Widget bodyView() => StreamBuilder<List<FullPokemon>>(
      stream: _streamController.stream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: PokeballSpinner(),
          );
        } else if (snapshot.data?.length == 0) {
          if (_isLoading) {
            return const Center(
              child: PokeballSpinner(),
            );
          } else {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Nothing was found for your query, try changing the search value.',
                style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: ColorConstants.descriptionGrey),
              ),
            );
          }
        } else if (snapshot.hasData) {
          final view = _isGridEnabled
              ? twinColumnGrid(snapshot)
              : singleColumnGrid(snapshot);
          return view;
        } else if (snapshot.hasError) {
          return Text('Error ${snapshot.hasData}');
        } else {
          return Container();
        }
      });

  Widget twinColumnGrid(snapshot) => RefreshIndicator(
        onRefresh: pullToRefresh,
        child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 9,
              crossAxisSpacing: 9,
            ),
            itemCount: snapshot.data?.length + 2,
            itemBuilder: (context, index) {
              if (index < snapshot.data?.length) {
                return TwinColumnCell(snapshot: snapshot, index: index);
              } else {
                if (snapshot.data?.length <
                        paginationService.currentList.length &&
                    snapshot.data?.length != 0) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: PokeballSpinner(),
                    ),
                  );
                } else {
                  return null;
                }
              }
            }),
      );

  Widget singleColumnGrid(snapshot) => RefreshIndicator(
        onRefresh: pullToRefresh,
        child: GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 2.7,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: snapshot.data?.length + 1,
            itemBuilder: (context, index) {
              if (index < snapshot.data?.length) {
                return SingleColumnCell(snapshot: snapshot, index: index);
              } else {
                if (snapshot.data?.length <
                        paginationService.currentList.length &&
                    snapshot.data?.length != 0) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: PokeballSpinner(),
                    ),
                  );
                } else {
                  return null;
                }
              }
            }),
      );

  Future<void> pullToRefresh() async {
    resetData();
    loadPokemons(filter);
  }
}
