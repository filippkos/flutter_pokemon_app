import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/gen/assets.gen.dart';
import 'package:flutter_pokemon_app/generated/l10n.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/debouncer.dart';
import 'package:flutter_pokemon_app/services/pagination/pagination.dart';
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
  final ScrollController _scrollController = ScrollController();
  final Pagination _paginationService = Pagination();
  final _updateDataStreamController = StreamController<List<FullPokemon>>();
  final _searchDebouncer = Debouncer(milliseconds: 1500);
  SearchField? _searchField;

  List<FullPokemon> _commonFullPokemonList = [];

  var _appBarRightIcon = Icons.grid_view;
  var _isGridEnabled = false;
  var _isLoading = false;

  String? filter;
  int page = 10;
  int limit = 10;
  int offset = 0;

  @override
  void dispose() {
    _updateDataStreamController.close();
    _scrollController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _searchField = SearchField(pullToRefreshCallback: pullToRefresh);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        loadPokemons(filter);
      }
    });

    _searchField?.textEditingController.addListener(() {
      _searchDebouncer.run(() {
        String? text = _searchField?.textEditingController.text;
        if (text != null) {
          text = text.isEmpty ? null : text;
          if (text != filter) {
            resetData(text);
            loadPokemons(filter);
          }
        }
      });
    });

    loadingInit();
  }

  resetData(String? text) {
    filter = text;
    limit = page;
    offset = 0;
    _commonFullPokemonList.clear();
    _updateDataStreamController.add(_commonFullPokemonList);
  }

  loadingInit() async {
    await _paginationService.prepareAllShortList();
    loadPokemons(filter);
  }

  loadPokemons(String? filter) async {
    _isLoading = true;
    _commonFullPokemonList = await _paginationService.getPage(
        filter, limit, _commonFullPokemonList.length);
    _updateDataStreamController.add(_commonFullPokemonList);
    limit += page;
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                _appBarRightIcon,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              onPressed: () {
                setState(() {
                  _isGridEnabled = !_isGridEnabled;
                  if (_isGridEnabled == true) {
                    _appBarRightIcon = Icons.view_agenda_outlined;
                  } else {
                    _appBarRightIcon = Icons.grid_view;
                  }
                });
              },
            ),
          ],
          surfaceTintColor: ColorConstants.wildSand,
          title: Text(
            S.of(context).listAppBarTitle,
            style: Theme.of(context).textTheme.headlineLarge
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: IconButton(
            padding: EdgeInsets.all(15),
            onPressed: () => Navigator.pop(context),
            icon: Assets.images.appIcon.android.image(),
          ),
          scrolledUnderElevation: 0,
        ),
        body: Column(
          children: [_searchField!, Expanded(child: bodyView())],
        ));
  }

  Widget bodyView() => StreamBuilder<List<FullPokemon>>(
      stream: _updateDataStreamController.stream,
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
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                S.of(context).listNothingFoundMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ColorConstants.descriptionGrey)
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
                        _paginationService.currentList.length &&
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
                        _paginationService.currentList.length &&
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
    await resetData(filter);
    loadPokemons(filter);
  }
}
