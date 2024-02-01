import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view/views/full_chip.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view/views/image_chip.dart';
import 'package:flutter_pokemon_app/ui/views/chip_view/views/text_chip.dart';

enum ChipViewFormat { imageOnly, textOnly, imageAndText }

class ChipView extends StatefulWidget {
  
  final ChipViewFormat format;
  final List<ChipModel> items;

  ChipView({super.key, required this.format, required this.items});

  @override
  ChipViewState createState() => ChipViewState();
}

class ChipViewState extends State<ChipView> {

  @override
  ChipView get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: switch (widget.format) {
        ChipViewFormat.imageOnly => widget.items
            .map((i) => ImageChip(image: i.image, backgroundColor: i.backgroundColor, color: i.textColor))
            .toList(),
        ChipViewFormat.textOnly => widget.items
            .map((i) => TextChip(title: i.title, color: i.backgroundColor))
            .toList(),
        ChipViewFormat.imageAndText => widget.items
            .map((i) => FullChip(title: i.title, image: i.image, color: i.backgroundColor, textColor: i.textColor))
            .toList()
      }
    );
  }
}
