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
    'bg/bg2.png',
    'bullets/bullet.png',
    'enemies/spider-enemy-1.png',
    'enemies/spider-enemy-2.png',
    'enemies/spider-enemy-3.png',
    'enemies/nautilus-enemy-1.png',
    'enemies/nautilus-enemy-2.png',
    'enemies/nautilus-enemy-3.png'
  ]);

  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'sfx/explosion.mp3',
    'sfx/fire-bullet.mp3',
  ]);


  GameLoop gameLoop = GameLoop();
  TapGestureRecognizer tapper = TapGestureRecognizer();
  tapper.onTapDown = gameLoop.onTapDown;
  runApp(gameLoop.widget);
  flameUtil.addGestureRecognizer(tapper);
}
