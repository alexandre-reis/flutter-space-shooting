import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Alien {
  Rect alienRect;
  Paint alientPaint;
  final GameLoop gameLoop;
  bool isDead = false;

  Alien(this.gameLoop, double x, double y) {
    alienRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize);
    alientPaint = Paint();
    alientPaint.color = Colors.deepOrange;
  }

  void render(Canvas canvas) {
    canvas.drawRect(alienRect, alientPaint);
  }

  void update(double time) {
    if (isDead) {
      alienRect = (alienRect.translate(0, (gameLoop.tileSize * 8 * time) * -1));
    }
  }

  void onTapDown() {
    isDead = !isDead;
    alientPaint.color = Color(0xff2ed573);
    gameLoop.spawnAlien();
  }
}
