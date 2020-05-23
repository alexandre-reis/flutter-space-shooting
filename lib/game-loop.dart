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
import 'package:spaceshooting/controllers/spawner.dart';

class GameLoop extends Game {
  Size screenSize;
  double tileSize;
  List<Enemy> enemies;
  List<Bullet> bullets;
  Random random;
  Background background;

  EnemySpawner spawner;

  GameLoop() {
    initialize();
  }

  void initialize() async {
    enemies = List<Enemy>();
    bullets = List<Bullet>();
    random = Random();
    resize(await Flame.util.initialDimensions());
    background = Background(this);
    spawner = EnemySpawner(this);
    // fireBullet();
  }

  void spawnEnemy() {
    double x = random.nextDouble() * (screenSize.width - tileSize);
    double y = random.nextDouble() * (screenSize.height - tileSize);
    enemies.add(Enemy(this, x, 10));
  }

  void fireBullet() {
    double x = random.nextDouble() * (screenSize.width - tileSize);
    double y = (screenSize.height - tileSize);
    bullets.add(Bullet(this, x, y));
  }

  void render(Canvas canvas) {
    background.render(canvas);
    enemies.forEach((Enemy alien) => alien.render(canvas));
    bullets.forEach((Bullet bullet) => bullet.render(canvas));
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
    fireBullet();
  }
}
