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
    // backgroundSprite = Sprite("background/background${rnd.nextInt(2).toString()}.png");
    // backgroundRect = Rect.fromLTWH(
    //   0, 
    //   gameLoop.screenSize.height,
    //   gameLoop.tileSize * 9, 
    //   gameLoop.tileSize * 23);
    double screenCenterX = gameLoop.screenSize.width / 2;
    double screenCenterY = gameLoop.screenSize.height / 2;
    backgroundRect = Rect.fromLTWH(
      screenCenterX - 10,
      screenCenterY - 55,
      50,
      50
    );
  }

  void render(Canvas canvas) {       
    Paint boxPaint = Paint();
    boxPaint.color = Colors.redAccent;
    canvas.drawRect(backgroundRect, boxPaint);
    // backgroundSprite.renderRect(canvas, backgroundRect);
  }

  void update(double time){}

}