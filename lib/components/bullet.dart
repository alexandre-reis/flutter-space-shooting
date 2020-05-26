import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Bullet {
  Rect bulletRect;
  Sprite deadSprite;
  final double width = 15;
  final double height = 15;

  final GameLoop gameLoop;
  bool isOffScreen = false;
  bool toDestroy = false;

  Bullet(this.gameLoop, double x, double y){

    Flame.audio.play('sfx/fire-bullet.mp3');    
    bulletRect = Rect.fromLTWH(x-(width/2), y, width, height);
    deadSprite = Sprite('bullets/bullet.png');

  }

  void render(Canvas canvas) {
    deadSprite.renderRect(canvas, bulletRect.inflate(2));
  }

  void update(double time) {
    bulletRect = (bulletRect.translate(0, gameLoop.tileSize * -10 * time));

    if (bulletRect.top > gameLoop.screenSize.height) {
      isOffScreen = true;
    }
  }

  void destroy() {
    toDestroy = !toDestroy;
  }
}