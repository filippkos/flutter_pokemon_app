import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';
import 'package:flutter_pokemon_app/services/pagination_service.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view.dart';
import 'package:http/http.dart' as http;

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  NetworkService networkService = NetworkService();
  ScrollController scrollController = ScrollController();
  Pagination paginationService = Pagination();
  final TextEditingController _textEditingController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);

  List<FullPokemon> _commonFullPokemonList = [];
  var streamController = new StreamController<List<FullPokemon>>();

  var _isSearchEnabled = false;
  var _isGridEnabled = false;
  var _isLoading = false;
  var _axis = 1;
  dynamic icon = Icons.grid_view;
  List<Widget> cells = [];
  String? filter;
  int limit = 10;
  int offset = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent && !_isLoading) {
        loadPokemons(filter);
      }
    });

    _textEditingController.addListener(() {
      _debouncer.run(() {
        var text = _textEditingController.text;
        _isSearchEnabled = text != '' ? true : false;
        filter = text != '' ? text : null;
        loadPokemons(filter);
      });
    });

    loadingInit();
  }

  loadingInit() async {
    await paginationService.prepareAllShortList();
    loadPokemons(filter);
  }

  loadPokemons(String? filter) async {
    _isLoading = true;
    _commonFullPokemonList = await paginationService.getPage(filter, limit, _commonFullPokemonList.length);
    streamController.add(_commonFullPokemonList);
    limit += limit;
    _isLoading = false;
  }

  // if (list.length < commonOffset + commonLimit) {
  //   commonOffset = commonOffset;
  // } else if (list.length > commonOffset + commonLimit){
  //   commonOffset = list.length;
  // } else if (list.length >= commonOffset) {
  //   commonLimit = 0;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.wildSand,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              icon,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isGridEnabled = !_isGridEnabled;
                if (_isGridEnabled == true) {
                  _axis = 2;
                  icon = Icons.view_agenda_outlined;
                  cells = [];
                } else {
                  _axis = 1;
                  icon = Icons.grid_view;
                  cells = [];
                }
              });
            },
          ),
        ],
        surfaceTintColor: ColorConstants.wildSand,
        title: const Text(
          'All pokemon',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans', 
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: ColorConstants.wildSand,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: SearchBar(
              controller: _textEditingController,
              constraints: const BoxConstraints(
                minHeight: 40
              ),
              elevation: MaterialStateProperty.all(0.0),
              hintText: 'Name or number...',
              hintStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontFamily: 'Plus Jakarta Sans', 
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: ColorConstants.heather
                )
              ),
              leading: Icon(Icons.search),
              backgroundColor: MaterialStateProperty.all(
                const Color.fromRGBO(255,255,255,1)
              ),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
          Expanded(child: bodyView())
        ],
      )
    );
  }

  Widget bodyView() => StreamBuilder<List<FullPokemon>>(
    stream: streamController.stream,
    builder: (context, AsyncSnapshot snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
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
    }
  );

  Widget twinColumnGrid(snapshot) => GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        mainAxisSpacing: 9,
        crossAxisSpacing: 9,
      ),
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        return twinColumnCell(snapshot, index);
      });

  Widget singleColumnGrid(snapshot) => GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 2.7,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        return singleColumnCell(snapshot, index);
      });

  Widget singleColumnCell(snapshot, index) => InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/details',
            arguments: snapshot.data[index]);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: ColorConstants.heather.withAlpha(60),
              spreadRadius: 0,
              blurRadius: 10
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.height * 0.12,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: _modelList(snapshot.data[index].types)
                          .first
                          .backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(
                          MediaQuery.of(context).size.height * 0.6))),
                ),
                Image(
                  image:
                      NetworkImage(snapshot.data[index].sprites.frontDefault),
                  alignment: Alignment.center,
                ),
              ],
            ),
            Container(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${snapshot.data[index].name}'.capitalizeFirst(),
                  maxLines: 1,
                  style: const TextStyle(
                      fontFamily: 'Paytone One',
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: ColorConstants.abbey),
                ),
                Spacer(),
                ChipView(
                  format: ChipViewFormat.imageAndText,
                  items: _modelList(snapshot.data[index].types),
                ),
                Spacer(),
                Text(
                  '#' + '${snapshot.data[index].id}'.padLeft(3, '0'),
                  style: const TextStyle(
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: ColorConstants.heather),
                ),
              ],
            ),
            Spacer()
          ],
        ),
      ));

  Widget twinColumnCell(snapshot, index) => InkWell(
    onTap: () {
      Navigator.pushNamed(context, '/details',
          arguments: snapshot.data[index]);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: ColorConstants.heather.withAlpha(60),
            spreadRadius: 0,
            blurRadius: 10
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '#' + '${snapshot.data[index].id}'.padLeft(3, '0'),
              style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: ColorConstants.heather),
            ),
          ),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.123,
                width: MediaQuery.of(context).size.height * 0.123,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: _modelList(snapshot.data[index].types)
                        .first
                        .backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.height * 0.0615))),
              ),
              Image(
                image:
                    NetworkImage(snapshot.data[index].sprites.frontDefault),
                alignment: Alignment.center,
              ),
            ],
          ),
          Spacer(),
          Text(
            '${snapshot.data[index].name}'.capitalizeFirst(),
            maxLines: 1,
            style: const TextStyle(
                fontFamily: 'Paytone One',
                fontWeight: FontWeight.w400,
                fontSize: 22,
                color: ColorConstants.abbey),
          ),
          Spacer(),
          ChipView(
            format: ChipViewFormat.imageOnly,
            items: _modelList(snapshot.data[index].types),
          ),
          Spacer()
        ],
      ),
    ),
  );

  List<ChipModel> _modelList(List<Type> types) {
    List<ChipModel> modelList = [];
    types.forEach((type) {
      ChipModel model = ChipModel(title: '');
      model.fillWithPokemonName(type.type.name);
      modelList.add(model);
    });

    return modelList;
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}