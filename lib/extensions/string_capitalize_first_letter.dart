import 'package:flutter/material.dart';

extension StringExtension on String {
    String capitalizeFirst() {
      return "${this.characters.first.toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}