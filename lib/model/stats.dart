import 'package:flutter/cupertino.dart';

class Stats extends ChangeNotifier {
  int flipX;
  int flipY;
  int flipZ;

  Stats(this.flipX, this.flipY, this.flipZ);

  int getFlipX() {
    return flipX;
  }

  int getFlipY() {
    return flipY;
  }

  int getFlipZ() {
    return flipZ;
  }

  int getTotalFlips() {
    return flipX + flipY + flipZ;
  }

  void resetFlips() {
    flipX = 0;
    flipY = 0;
    flipZ = 0;
  }

}