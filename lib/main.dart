import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaceshooting/game-loop.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  Flame.images.loadAll(<String>[
    'bg/bg1.png',
    'bg/bg2.png'
  ]);

  GameLoop gameLoop = GameLoop();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameLoop.onTapDown;
  runApp(gameLoop.widget);
  flameUtil.addGestureRecognizer(tapper);
}
