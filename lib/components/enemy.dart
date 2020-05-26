import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooting/game-loop.dart';

class Enemy {
  Rect enemyRect;
  List<Sprite> walkingSprite;
  double walkingSpriteIndex = 0;
  final GameLoop gameLoop;
  bool isDead = false;
  bool isOffScreen = false;
  Offset targetLocation;
  double get speed => gameLoop.tileSize * 6;

  Enemy(this.gameLoop) {
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = gameLoop.random.nextDouble() * (gameLoop.screenSize.width - (gameLoop.tileSize * 2.025));
    double y = gameLoop.random.nextDouble() * (gameLoop.screenSize.height - (gameLoop.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas canvas) {
    walkingSprite[walkingSpriteIndex.toInt()].renderRect(canvas, enemyRect.inflate(2));
  }

  void update(double time) {
    // enemyRect = (enemyRect.translate(0, gameLoop.tileSize * 6 * time));

    if (enemyRect.top > gameLoop.screenSize.height) {
      isOffScreen = true;
      isDead = !isDead;
    }

    walkingSpriteIndex += 15 * time;
    if (walkingSpriteIndex >= walkingSprite.length) {
      walkingSpriteIndex -= walkingSpriteIndex.toInt();
    }

    double stepDistance = speed * time;
    Offset toTarget = targetLocation - Offset(enemyRect.left, enemyRect.top);
    if (stepDistance < toTarget.distance) {
      Offset stepToTarget = Offset.fromDirection(toTarget.direction, stepDistance);
      enemyRect = enemyRect.shift(stepToTarget);
    } else {
      enemyRect = enemyRect.shift(toTarget);
      setTargetLocation();
    }
  }

  void kill() {
    isDead = !isDead;
  }
}
