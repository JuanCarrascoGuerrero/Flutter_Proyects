import 'dart:ui';

import 'package:flutter/material.dart';

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height);  // Bottom-right corner
    path.lineTo(0, size.height);  // Bottom-left corner
    path.lineTo(size.width, 0);  // **Top-right corner** (new adjustment)
    path.close();  // Complete the triangle
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}