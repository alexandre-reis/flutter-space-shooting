import 'dart:math';
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/gestures.dart';
import 'package:spaceshooting/components/alien.dart';

class GameLoop extends Game {
  Size screenSize;
  double tileSize;
  List<Alien> aliens;
  Random random;

  GameLoop() {
    initialize();
  }

  void initialize() async {
    aliens = List<Alien>();
    random = Random();
    resize(await Flame.util.initialDimensions());

    spawnAlien();
  }

  void spawnAlien() {
    double x = random.nextDouble() * (screenSize.width - tileSize);
    double y = random.nextDouble() * (screenSize.height - tileSize);
    aliens.add(Alien(this, x, y));
  }

  void render(Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Colors.blueAccent;
    canvas.drawRect(rect, bgPaint);

    aliens.forEach((Alien alien) => alien.render(canvas));
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void update(double time) {
    // aliens.forEach((Alien alien) => alien.update(time));s
    aliens.removeWhere((alien) => alien.isDead);
  }

  void onTapDown(TapDownDetails d) {
    List<Alien>.from(aliens).forEach((alien) {
      if (alien.alienRect.contains(d.globalPosition)) {
        alien.onTapDown();
      }
    });
  }
}
