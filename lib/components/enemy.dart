import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Enemy {
  Rect enemyRect;
  Paint enemyPaint;
  final GameLoop gameLoop;
  bool isDead = false;
  bool isOffScreen = false;

  Enemy(this.gameLoop, double x, double y) {
    enemyRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize);
    enemyPaint = Paint();
    enemyPaint.color = Colors.deepOrange;
  }

  void render(Canvas canvas) {
    canvas.drawRect(enemyRect, enemyPaint);
  }

  void update(double time) {
    // if (isDead) {
      enemyRect = (enemyRect.translate(0, gameLoop.tileSize * 5 * time));
      
      if (enemyRect.top > gameLoop.screenSize.height) {
        isOffScreen = true;
        isDead = !isDead;

      }

    // }
  }

  void onTapDown() {
    isDead = !isDead;
    enemyPaint.color = Colors.purple;
    // gameLoop.spawnEnemy();
  }
}
