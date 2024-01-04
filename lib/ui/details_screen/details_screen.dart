import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';
import 'package:http/http.dart' as http;


class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});
  
  
  @override
  State<StatefulWidget> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final pokemon = ModalRoute.of(context)?.settings.arguments as FullPokemon;

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
         
        ],
        surfaceTintColor: ColorConstants.wildSand,
        title: Text(
          'Base experience',
          style: TextStyle(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
        backgroundColor: ColorConstants.wildSand,
      ),
      body: Container(
        color: ColorConstants.abbey,
        child: Text(
          pokemon.name,
           style: TextStyle(
            fontFamily: 'Paytone One',
            fontWeight: FontWeight.w800,
            fontSize: 50
          ),
        ),
      ),
    );
  }
}