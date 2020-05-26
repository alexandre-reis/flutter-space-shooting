import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/gestures.dart';
import 'package:spaceshooting/components/background.dart';
import 'package:spaceshooting/components/bullet.dart';
import 'package:spaceshooting/components/enemy.dart';
import 'package:spaceshooting/components/nautilus-enemy.dart';
import 'package:spaceshooting/components/score-display.dart';
import 'package:spaceshooting/components/spider-enemy.dart';
import 'package:spaceshooting/controllers/spawner.dart';

class GameLoop extends Game {
  Size screenSize;
  double tileSize;
  List<Enemy> enemies;
  List<Bullet> bullets;
  Random random;
  Background background;
  ScoreDisplay scoreDisplay;
  EnemySpawner spawner;


  int score;

  GameLoop() {
    initialize();
  }

  void initialize() async {
    score = 0;
    enemies = List<Enemy>();
    bullets = List<Bullet>();
    random = Random();
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    scoreDisplay = ScoreDisplay(this);
    spawner = EnemySpawner(this);
  }

  void spawnEnemy() {
    double x = random.nextDouble() * (screenSize.width - tileSize * 2.025);
    double y = 10 * (screenSize.width - tileSize * 2.025);
    switch (random.nextInt(2)) {
      case 0:
        enemies.add(NautilusEnemy(this, x, 10));
        break;
      case 1:
        enemies.add(SpiderEnemy(this, x, 10));
        break;
    }
  }

  void fireBullet(num dx) {
    double y = (screenSize.height - tileSize);

    bullets.add(Bullet(this, dx, y));
  }

  void render(Canvas canvas) {
    background.render(canvas);
    enemies.forEach((Enemy alien) => alien.render(canvas));
    bullets.forEach((Bullet bullet) => bullet.render(canvas));
    scoreDisplay.render(canvas);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void update(double time) {
    spawner.update(time);
    enemies.forEach((Enemy enemy) => enemy.update(time));
    bullets.forEach((Bullet bullet) => bullet.update(time));
    enemies.removeWhere((enemy) => enemy.isOffScreen || enemy.isDead);
    bullets.removeWhere((bullet) => bullet.isOffScreen || bullet.toDestroy);
    List<Enemy>.from(enemies).forEach((enemy) {
      List<Bullet>.from(bullets).forEach((bullet) {
        if (checkColision(enemy.enemyRect, bullet.bulletRect)) {
          enemy.kill();
          bullet.destroy();          
        }
      });
    });
    scoreDisplay.update(time);
  }

  bool checkColision(Rect enemyRect, Rect bulletRect) {
    if (enemyRect.contains(bulletRect.topCenter) ||
        enemyRect.contains(bulletRect.topLeft) ||
        enemyRect.contains(bulletRect.topRight)) {
      return true;
    }
    return false;
  }

  void onTapDown(TapDownDetails d) {
    print('global');
    print(d.localPosition);
    // print(d.globalPosition.dx);ÇL>
    fireBullet(d.globalPosition.dx);
  }
}
