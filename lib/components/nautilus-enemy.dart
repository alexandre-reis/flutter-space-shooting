import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:spaceshooting/components/enemy.dart';
import 'package:spaceshooting/game-loop.dart';

class NautilusEnemy extends Enemy {

  int get pointsPerKill => 25;
  
  NautilusEnemy(GameLoop gameLoop, double x, double y) : super(gameLoop) {
    walkingSprite = List<Sprite>();
    walkingSprite.add(Sprite('enemies/nautilus-enemy-1.png'));
    walkingSprite.add(Sprite('enemies/nautilus-enemy-2.png'));
    walkingSprite.add(Sprite('enemies/nautilus-enemy-3.png'));

    enemyRect = Rect.fromLTWH(x, y, gameLoop.tileSize * 1.65, gameLoop.tileSize * 1.65);

  }
  
}
