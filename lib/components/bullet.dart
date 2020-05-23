import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Bullet {
  Rect bulletRect;
  Paint bulletPaint;
  final GameLoop gameLoop;
  bool isOffScreen = false;
  bool toDestroy = false;

  Bullet(this.gameLoop, double x, double y){
    bulletRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize);
    bulletPaint = Paint();
    bulletPaint.color = Colors.lightGreenAccent;
  }

  void render(Canvas canvas) {
    canvas.drawRect(bulletRect, bulletPaint);
  }

  void update(double time) {
    bulletRect = (bulletRect.translate(0, gameLoop.tileSize * -5 * time));

    if (bulletRect.top > gameLoop.screenSize.height) {
      isOffScreen = true;
    }
  }

  void destroy() {
    toDestroy = !toDestroy;
    bulletPaint.color = Colors.purple;    
  }
}