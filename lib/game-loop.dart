import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/gestures.dart';
import 'package:spaceshooting/components/background.dart';
import 'package:spaceshooting/components/enemy.dart';
import 'package:spaceshooting/controllers/spawner.dart';

class GameLoop extends Game {
  Size screenSize;
  double tileSize;
  List<Enemy> enemies;
  Random random;
  Background background;

  EnemySpawner spawner;


  GameLoop() {
    initialize();
  }

  void initialize() async {
    enemies = List<Enemy>();
    random = Random();
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    spawner = EnemySpawner(this);
    // spawnEnemy();
  }

  void spawnEnemy() {
    double x = random.nextDouble() * (screenSize.width - tileSize);
    double y = random.nextDouble() * (screenSize.height - tileSize);
    enemies.add(Enemy(this, x, 10));
  }

  void render(Canvas canvas) {
    // Rect rect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    // Paint bgPaint = Paint();
    // bgPaint.color = Colors.blueAccent;
    // canvas.drawRect(rect, bgPaint);
    background.render(canvas);

    enemies.forEach((Enemy alien) => alien.render(canvas));
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void update(double time) {
    spawner.update(time);
    enemies.forEach((Enemy alien) => alien.update(time));
    enemies.removeWhere((alien) => alien.isOffScreen);
  }

  void onTapDown(TapDownDetails d) {
    List<Enemy>.from(enemies).forEach((enemy) {
      if (enemy.enemyRect.contains(d.globalPosition)) {
        enemy.onTapDown();
      }
    });
  }
}
