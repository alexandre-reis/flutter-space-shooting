import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:spaceshooting/components/enemy.dart';
import 'package:spaceshooting/game-loop.dart';

class SpiderEnemy extends Enemy {
  SpiderEnemy(GameLoop gameLoop, double x, double y) : super(gameLoop) {
    walkingSprite = List<Sprite>();
    walkingSprite.add(Sprite('enemies/spider-enemy-1.png'));
    walkingSprite.add(Sprite('enemies/spider-enemy-2.png'));
    walkingSprite.add(Sprite('enemies/spider-enemy-3.png'));

    enemyRect = Rect.fromLTWH(x, y, gameLoop.tileSize * 1.5, gameLoop.tileSize * 1.5);

  }
}
