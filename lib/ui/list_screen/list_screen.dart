import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
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
  Future<PokemonList>? takenPokemonList;
  Future<List<FullPokemon>>? fullPokemonList;
  var _isGridEnabled = false;
  var _axis = 1;
  dynamic icon = Icons.grid_view;
  List<Widget> cells = [];
  var aspect = 3.0;

  @override
  void initState() {
    super.initState();
    // takenPokemonList = networkService.getPokemonList();

    fullPokemonList = getPokemons();
  }

  Future<List<FullPokemon>> getPokemons() async {
    List<FullPokemon> list = [];
     networkService.getPokemonList().then((value) => {
      value.results.forEach((e) => {
        networkService.getFullPokemon(e.url).then((value) => {
          list.add(value)
        })
      })
    });
    return list;
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
      body: FutureBuilder<List<FullPokemon>>(
        future: fullPokemonList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            var view = _isGridEnabled 
              ? twinColumnGrid(snapshot)
              : singleColumnGrid(snapshot);
            return view;
          } else if (snapshot.hasError) {
            return Text('Error');
          }
          return Container();
        }
      )
    );
  }

  Widget twinColumnGrid(snapshot) => GridView.builder(
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
        Image(
          image: NetworkImage(snapshot.data[index].sprites.frontDefault),
          ),
        Spacer(),
        Text('${snapshot.data[index].name}')
      ],
    ),
  );

  Widget twinColumnCell(snapshot, index) => Container(
    padding: EdgeInsets.all(16),
    color: Colors.white,
    child: Column(
      children:[
        Image(
          image: NetworkImage(snapshot.data[index].sprites.frontDefault),
          ),
        Spacer(),
        Text('${snapshot.data[index].name}')
      ],
    ),
  );
}