
import 'dart:ui';

import 'package:flutter/material.dart';

getColorType(int number) {
  switch (number.toInt()) {

    case 0:
      return Colors.grey;
    case 1:
      return Colors.teal;
    case 2:
      return Colors.deepPurple;
    case 3:
      return Colors.orangeAccent;
    case 4:
      return Colors.red;
  }
  return Colors.amberAccent;
}