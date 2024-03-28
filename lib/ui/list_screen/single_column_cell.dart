import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/extensions/string_capitalize_first_letter.dart';
import 'package:flutter_pokemon_app/gen/fonts.gen.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';
import 'package:flutter_pokemon_app/models/full_pokemon_model.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view/chip_view.dart';

class SingleColumnCell extends StatelessWidget {

  final AsyncSnapshot snapshot;
  final int index;

  const SingleColumnCell({super.key, required this.snapshot, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/details',
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                      '${snapshot.data[index].name}'.capitalizeFirst(),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context).textTheme.titleLarge
                    ),
                  
                  Spacer(),
                  ChipView(
                    format: ChipViewFormat.imageAndText,
                    items: _modelList(snapshot.data[index].types),
                  ),
                  Spacer(),
                  Text(
                    '#' + '${snapshot.data[index].id}'.padLeft(3, '0'),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorConstants.heather)
                  ),
                ],
              ),
            ),
          ],
        ),
      )
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