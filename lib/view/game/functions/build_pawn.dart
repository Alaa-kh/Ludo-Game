import 'package:flutter_application_2/core/constants/app_packages.dart';

List<Widget> buildPawnWidgets() {
  List<Widget> playerPawns = [];

  for (int playerIndex = 0; playerIndex < 4; playerIndex++) {
    Color playerColor;
    switch (playerIndex) {
      case 0:
        playerColor = AppColors.greenColor;
        break;
      case 1:
        playerColor = AppColors.redColor;
        break;
      case 2:
        playerColor = AppColors.blueColor;
        break;
      default:
        playerColor = AppColors.yellowColor;
    }
    for (int i = 0; i < 4; i++) {
      playerPawns.add(SizedBox.expand(
        child: AnimatedBuilder(
          builder: (_, child) => CustomPaint(
              painter: PlayersPainter(
                  playerCurrentSpot: playerAnimationList[playerIndex][i].value,
                  playerColor: playerColor)),
          animation: playerAnimationList[playerIndex][i],
        ),
      ));
    }
  }

  return playerPawns;
}
