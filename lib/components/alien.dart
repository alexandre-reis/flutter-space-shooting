import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Alien {
  Rect alienRect;
  Paint alientPaint;
  final GameLoop gameLoop;

  Alien(this.gameLoop, double x, double y) {
    alienRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize);
    alientPaint = Paint();
    alientPaint.color = Colors.deepOrange;
  }

  void render(Canvas canvas) {
    canvas.drawRect(alienRect, alientPaint);
  }

  void update(double time) {}
}
