import 'package:flutter/material.dart';

class FullChip extends StatelessWidget {
  final String title;
  final Image? image;
  final Color? color;
  final Color? textColor;

  const FullChip(
      {super.key,
      required this.title,
      required this.image,
      required this.color,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(5),
      labelPadding: EdgeInsets.only(left: 1),
      labelStyle:
          Theme.of(context).textTheme.labelSmall?.copyWith(color: textColor),
      label: Text(title),
      avatar: image,
      backgroundColor: color,
      side: const BorderSide(style: BorderStyle.none),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }
}
