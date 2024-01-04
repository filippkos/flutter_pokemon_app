import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';
import 'package:http/http.dart' as http;


class ListScreen extends StatefulWidget {
  const ListScreen({super.key});
  
  @override
  State<StatefulWidget> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  NetworkService networkService = NetworkService();
  ScrollController scrollController = ScrollController();
  Future<PokemonList>? takenPokemonList;
  Future<List<FullPokemon>>? fullPokemonList;
  List<FullPokemon> fullList = [];
  var _isGridEnabled = false;
  var _axis = 1;
  dynamic icon = Icons.grid_view;
  List<Widget> cells = [];
  var aspect = 3.0;
  var page = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchCommonlist();
      }
    });
    fullPokemonList = fetchCommonlist();
  }

  Future<List<FullPokemon>> fetchCommonlist() async {
    getPokemons().then((list) {
      setState(() {
        fullList.addAll(list);
      });
    });

    return fullList;
  }

  Future<List<FullPokemon>> getPokemons() async {
    final list = await networkService.getPokemonList(20, fullList.length.toString());
    final array = list.results.map((e) => networkService.getFullPokemon(e.url));

    return Future.wait(array);
  }

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
                    aspect = 0.8;
                  } else {
                    _axis = 1;
                    icon = Icons.grid_view;
                    cells = [];
                    aspect = 3;
                  }
                }
                );
              },
            ),
          ],
        surfaceTintColor:  ColorConstants.wildSand,
        title: Text(
          'All pokemon',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: ColorConstants.wildSand,
      ),
      body: bodyView()
    );
  }

  Widget bodyView() => FutureBuilder<List<FullPokemon>>(
    future: fullPokemonList,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return  Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.hasData) {
        var view = _isGridEnabled 
          ? twinColumnGrid(snapshot)
          : singleColumnGrid(snapshot);
        return view;
      } else if (snapshot.hasError) {
        return Text('Error');
      }
      return Container();
    }
  );

  Widget twinColumnGrid(snapshot) => GridView.builder(
    controller: scrollController,
    padding: EdgeInsets.all(16),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
    ), 
    itemCount: snapshot.data?.length,
    itemBuilder: (context, index) {
      return twinColumnCell(snapshot, index);
    }
  );

    Widget singleColumnGrid(snapshot) => GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ), 
      itemCount: snapshot.data?.length,
      itemBuilder: (context, index) {
        return singleColumnCell(snapshot, index);
      }
    );

  Widget singleColumnCell(snapshot, index) => Container(
    padding: EdgeInsets.all(16),
    color: Colors.white,
    child: Row(
      children: [
        Stack(
          children: [
            Container(
              height: 80, 
              width: 80, 
              alignment: Alignment.center, 
              decoration: BoxDecoration(
                color: ColorConstants.heather,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                 border: Border.all(
                  color: ColorConstants.heather,
                ),
              ),
            ),
            Image(
              image: NetworkImage(snapshot.data[index].sprites.frontDefault),
              alignment: Alignment.center,
            ),
         ],
        ),
        Spacer(flex: 1),
        Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            Text('${snapshot.data[index].name}'.capitalizeFirst(),
              style: TextStyle(
                fontFamily: 'Paytone One',
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: ColorConstants.abbey
              ),
            ),
            Spacer(),
            Text(
              '#'+'${snapshot.data[index].id}'.padLeft(3, '0'),
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: ColorConstants.heather
              ),
            ),
          ],
        ),
        Spacer(flex: 4)
      ],
    ),
  );

  Widget twinColumnCell(snapshot, index) => Container(
    padding: EdgeInsets.all(16),
    color: Colors.white,
    child: Column(
      children:[
        Align(
          alignment: Alignment.topRight, 
          child: Text(
            '#'+'${snapshot.data[index].id}'.padLeft(3, '0'),
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: ColorConstants.heather
            ),
          ),
        ),
        Stack(
          children: [
            Container(
              height: 100, 
              width: 100, 
              alignment: Alignment.center, 
              decoration: BoxDecoration(
                color: ColorConstants.heather,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                 border: Border.all(
                  color: ColorConstants.heather,
                ),
              ),
            ),
            Image(
              image: NetworkImage(snapshot.data[index].sprites.frontDefault),
              alignment: Alignment.center,
            ),
         ],
        ),
        Spacer(flex: 1),
        Text(
          '${snapshot.data[index].name}'.capitalizeFirst(),
          style: TextStyle(
            fontFamily: 'Paytone One',
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: ColorConstants.abbey
          ),
        ),
        Spacer(flex: 5)
      ],
    ),
  );
}