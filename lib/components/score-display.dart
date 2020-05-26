import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:spaceshooting/game-loop.dart';

class ScoreDisplay {
  final GameLoop gameLoop;
  TextPainter painter;
  TextStyle txtStyle;
  Offset position;

  ScoreDisplay(this.gameLoop) {
    painter = TextPainter(
      textAlign: TextAlign.center, 
      textDirection: TextDirection.rtl
    );

    txtStyle = TextStyle(
      color: Colors.white,
      fontSize: 20
    );

    position = Offset.zero;
  }

  void render(Canvas canvas) {
    painter.paint(canvas, position);
  }

  void update(double t) {
     if ((painter.text?.text ?? '') != gameLoop.score.toString()) {
      painter.text = TextSpan(
        text:'Score: ${gameLoop.score.toString().toString()}',
        style: txtStyle,
      );

      painter.layout();

      position = Offset(
        gameLoop.screenSize.width - (gameLoop.tileSize * .25) - painter.width,
        gameLoop.tileSize * .25,
      );
    }
  }
}
