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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              '#' + pokemon.id.toString().padLeft(3, '0'),
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w800,
                fontSize: 24,
                color: Colors.white
              ),
            ),
          )
        ],
        backgroundColor: _typeModelList(pokemon.types).first.textColor,
        title: const Text(
          'Base experience',
          style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.white),
        ),
        leading: IconButton(
            padding: EdgeInsets.all(15),
            onPressed: () => Navigator.pop(context),
            icon: Image.asset('assets/images/icon_buttons/back_arrow.png')),
        scrolledUnderElevation: 0,
      ),
      body: Container(
          decoration: BoxDecoration(
              color: _typeModelList(pokemon.types).first.textColor,
              gradient: LinearGradient(colors: [
                _typeModelList(pokemon.types).first.textColor ?? Colors.black,
                Colors.white
              ], begin: Alignment.topCenter, end: Alignment.center)),
          alignment: Alignment.center,
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                    color: _typeModelList(pokemon.types).first.backgroundColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Image(
                  fit: BoxFit.fill,
                  width: 200,
                  height: 200,
                  image: NetworkImage(pokemon.sprites.frontDefault),
                ),
              ),
              Container(
                height: 16,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white,
                  ),
                  padding:
                      EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Expanded(
                        child: Column(
                      children: [
                        Text(
                          pokemon.name.capitalizeFirst(),
                          style: const TextStyle(
                              fontFamily: 'Paytone One',
                              fontWeight: FontWeight.w800,
                              fontSize: 40,
                              color: ColorConstants.abbey),
                        ),
                        Container(height: 6),
                        ChipView(
                          format: ChipViewFormat.imageAndText,
                          items: _typeModelList(pokemon.types),
                        ),
                        Container(height: 20),
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
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
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
                                      color: ColorConstants.heather),
                                ),
                                ChipView(
                                    format: ChipViewFormat.textOnly,
                                    items: _modelMap(pokemon)[index]?.$2 ?? []),
                                Container(height: 15)
                              ],
                            );
                          },
                        ),
                      ],
                    )),
                  ),
                ),
              ),
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

  Map<int, (String, List<ChipModel>)> _modelMap(FullPokemon pokemon) {
    var map = {
      0: (
        'Abilities',
        pokemon.abilities
            .map((e) => ChipModel(title: e.ability.name.capitalizeFirst()))
            .toList()
      ),
      1: (
        'Forms',
        pokemon.forms
            .map((e) => ChipModel(title: e.name.capitalizeFirst()))
            .toList()
      ),
      2: (
        'Moves',
        pokemon.moves
            .map((e) => ChipModel(title: e.move.name.capitalizeFirst()))
            .toList()
      )
    };

    return map;
  }
}
