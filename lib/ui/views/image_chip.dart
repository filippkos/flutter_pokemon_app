import 'package:flutter/material.dart';

class ImageChip extends StatelessWidget {

  final Image? image;
  final Color? backgroundColor;
  final Color? color;

  const ImageChip({super.key, required this.image, required this.backgroundColor, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: backgroundColor,
      // foregroundColor: color,
      child: Container(
        padding: EdgeInsets.all(3),
        child: image,
      )
    );
  }
}