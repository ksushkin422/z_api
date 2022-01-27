
import 'dart:ui';

import 'package:flutter/material.dart';

getColorType(int number) {
  switch (number.toInt()) {
    case 1:
      return Colors.deepPurple;
    case 2:
      return Colors.teal;
    case 3:
      return Colors.lightBlue;
    case 4:
      return Colors.amberAccent;
    case 5:
      return Colors.purpleAccent;
    case 6:
      return Colors.green;
  }
  return Colors.red;
}