import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';

class TextChip extends StatelessWidget {

  final String title;
  final Color? color;

  const TextChip({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.all(5),
      labelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(color: ColorConstants.abbey),
      label: Text(title),
      backgroundColor: color,
      side: const BorderSide(style: BorderStyle.none),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}