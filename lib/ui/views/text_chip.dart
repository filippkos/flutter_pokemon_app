import 'package:flutter/material.dart';

class TextChip extends StatelessWidget {

  final String title;
  final Color? color;

  const TextChip({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.all(5),
      labelStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'Plus Jakarta Sans',
          fontWeight: FontWeight.w600,
          fontSize: 13),
      label: Text(title),
      backgroundColor: color,
      side: const BorderSide(style: BorderStyle.none),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
    );
  }
}