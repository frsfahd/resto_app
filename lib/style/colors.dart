import 'package:flutter/material.dart';

enum RestoColors {
  blue("Blue", Colors.blue),
  green("Green", Colors.green);

  const RestoColors(this.name, this.color);

  final String name;
  final Color color;
}
