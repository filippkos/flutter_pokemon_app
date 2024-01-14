import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';
import 'package:flutter_pokemon_app/models/pokemon_list_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/network_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_pokemon_app/ui/views/chip_view.dart';

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
        actions: const <Widget>[],
        surfaceTintColor: ColorConstants.wildSand,
        title: const Text(
          'Base experience',
          style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
        backgroundColor: ColorConstants.wildSand,
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                    color: _typeModelList(pokemon.types)
                          .first
                          .backgroundColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Image(
                  fit: BoxFit.fill,
                  width: 200,
                  height: 200,
                  image: NetworkImage(pokemon.sprites.frontDefault),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                        fontFamily: 'Paytone One',
                        fontWeight: FontWeight.w800,
                        fontSize: 40),
                  ),
                  ChipView(
                    format: ChipViewFormat.imageAndText, 
                    items: _typeModelList(pokemon.types),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      valueColumn('Height', pokemon.height.toString()),
                      const Spacer(),
                      valueColumn('Weight', pokemon.weight.toString()),
                      const Spacer(),
                      valueColumn('Order', pokemon.order.toString()),
                      const Spacer()
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      itemCount: _modelMap(pokemon).length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _modelMap(pokemon)[index]!.$1,
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: ColorConstants.heather
                              ),
                            ),
                            ChipView(
                              format: ChipViewFormat.textOnly, 
                              items: _modelMap(pokemon)[index]?.$2 ?? []
                            ),
                            Container(
                              height: 15
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              )),
            ],
          )),
    );
  }

  Widget valueColumn(title, value) => Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w500,
                color: ColorConstants.abbey,
                fontSize: 24),
          ),
          Text(
            title,
            style: const TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
                color: ColorConstants.heather,
                fontSize: 12),
          )
        ],
      );

  List<ChipModel> _typeModelList(List<Type> types) {
    List<ChipModel> modelList = [];
    types.forEach((type) {
      ChipModel model = ChipModel(title: '');
      model.fillWithPokemonName(type.type.name);
      modelList.add(model);
    });

    return modelList;
  }

  Map<int,(String, List<ChipModel>)> _modelMap(FullPokemon pokemon) {
    var map = {
      0:('Abilities', pokemon.abilities.map((e) => ChipModel(title: e.ability.name.capitalizeFirst())).toList()),
      1:('Forms', pokemon.forms.map((e) => ChipModel(title: e.name.capitalizeFirst())).toList()),
      2:('Moves', pokemon.moves.map((e) => ChipModel(title: e.move.name.capitalizeFirst())).toList())
    };
    
    return map;
  }
}


