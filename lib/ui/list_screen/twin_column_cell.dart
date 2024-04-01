import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/services/routes/app_route_keys.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view/chip_view.dart';

class TwinColumnCell extends StatelessWidget {

  final AsyncSnapshot snapshot;
  final int index;

  const TwinColumnCell({super.key, required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouteKeys.details,
            arguments: snapshot.data[index]);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.surface,
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
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorConstants.heather)
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
              style: Theme.of(context).textTheme.titleLarge
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
  }

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