import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Background {
  final GameLoop gameLoop;
  Sprite backgroundSprite;
  Rect backgroundRect;
  Random rnd;

  Background(this.gameLoop) {
    rnd = Random();
    backgroundSprite = Sprite('bg/bg${(rnd.nextInt(2) + 1).toString()}.png');
    backgroundRect = Rect.fromLTWH(
      0,
      gameLoop.screenSize.height - (gameLoop.tileSize * 18),
      gameLoop.tileSize * 9,
      gameLoop.tileSize * 18
    );
  }

  void render(Canvas canvas) {
    backgroundSprite.renderRect(canvas, backgroundRect);
    // Paint boxPaint = Paint();
    // boxPaint.color = Colors.redAccent;
    // canvas.drawRect(backgroundRect, boxPaint);
    // backgroundSprite.renderRect(canvas, backgroundRect);
  }

  void update(double time) {}
}
