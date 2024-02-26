import 'package:flutter_application_2/core/constants/app_packages.dart';

void alterTurn() {
  if (winnerPawnList.where((playerPawns) {
        return playerPawns.length == 4;
      }).length !=
      3) //if any 3 players have completed
  {
    accentuateDice();

    stepCounter = 0; //reset step counter for next turn
    if (!provideFreeTurn!) {
      do {
        //to ignore winners
        currentTurn =
            (currentTurn + 1) % 4; //change turn after animation completes
        if (winnerPawnList[currentTurn].length != 4) {
          break; //select player if he is not yet a winner
        }
      } while (true);
      straightSixesCounter = 0;
    } else if (diceOutput != 6)
      // ignore: curly_braces_in_flow_control_structures
      straightSixesCounter =
          0; //reset 6s counter if free turn is provided by other means

    if (playerHighlightAnimationCont!.isAnimating) accentuateCurrentPlayer();

    provideFreeTurn = false;
  }
}
