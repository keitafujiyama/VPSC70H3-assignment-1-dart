// PACKAGE
import 'package:flutter/material.dart';



class LineClass {

  // CONSTRUCTOR
  const LineClass (this.color, this.position);

  // PROPERTY
  final Color color;
  final double position;
}

class MinuteClass {

  // CONSTRUCTOR
  const MinuteClass (this.lines, this.minute);

  // PROPERTY
  final int minute;
  final List <LineClass> lines;
}
