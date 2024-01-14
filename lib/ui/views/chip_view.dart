import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/models/chip_model.dart';

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
  // TODO: implement widget
  ChipView get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: switch (widget.format) {
        ChipViewFormat.imageOnly => widget.items
            .map((i) => imageChip(i.image, i.backgroundColor, i.textColor))
            .toList(),
        ChipViewFormat.textOnly => widget.items
            .map((i) => textChip(i.title, i.backgroundColor))
            .toList(),
        ChipViewFormat.imageAndText => widget.items
            .map((i) =>
                fullChip(i.title, i.image, i.backgroundColor, i.textColor))
            .toList()
      }
    );
  }

  Widget fullChip(title, image, color, textColor) => Chip(
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    padding: const EdgeInsets.all(5),
    labelStyle: TextStyle(
        color: textColor,
        fontFamily: 'Plus Jakarta Sans',
        fontWeight: FontWeight.w600,
        fontSize: 15),
    label: Text(title),
    avatar: image,
    backgroundColor: color,
    side: const BorderSide(style: BorderStyle.none),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );

  Widget textChip(title, color) => Chip(
    padding: const EdgeInsets.all(5),
    label: Text(title),
    backgroundColor: color,
    side: const BorderSide(style: BorderStyle.none),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
  );

  Widget imageChip(image, backgroundcolor, color) => CircleAvatar(
    radius: 15,
    backgroundColor: backgroundcolor,
    // foregroundColor: color,
    child: Container(
      padding: EdgeInsets.all(3),
      child: image,
    )
  );
}
