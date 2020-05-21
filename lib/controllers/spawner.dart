
import 'package:spaceshooting/components/enemy.dart';
import 'package:spaceshooting/game-loop.dart';

class EnemySpawner {
  final GameLoop gameLoop;

  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 5000;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.gameLoop) {
    start();
    gameLoop.spawnEnemy();
  }

  void start() {
    killAll();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAll() {
    gameLoop.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    int livingFlies = 0;
    // gameLoop.enemies.forEach((Enemy enemy) {
    //   if (!enemy.isDead) livingFlies += 1;
    // });

    if (nowTimestamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      gameLoop.spawnEnemy();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * .1).toInt();
      }
      nextSpawn = nowTimestamp + currentInterval;
    }
  }
}
