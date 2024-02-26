import 'package:flutter_application_2/core/constants/app_packages.dart';

void handleClick(Offset clickOffset) {
  if (!diceHighlightAnimationCont!.isAnimating) {
    if (stepCounter == 0) {
      for (int pawnIndex = 0;
          pawnIndex < pawnCurrentStepInfoList[currentTurn].length;
          pawnIndex++) {
        if (pawnCurrentStepInfoList[currentTurn][pawnIndex]
            .value
            .contains(clickOffset)) {
          var clickedPawnIndex =
              pawnCurrentStepInfoList[currentTurn][pawnIndex].key;

          if (clickedPawnIndex == 0) {
            if (diceOutput == 6) {
              diceOutput = 1; //to move pawn out of the house when 6 is rolled
            } else {
              break; //disallow pawn selection because 6 is not rolled and the pawn is in house
            }
          } else if (clickedPawnIndex + diceOutput > maxTrackIndex)
            break; // disallow pawn selection because dice number is more than step left

          playerHighlightAnimationCont!.reset();
          selectedPawnIndex = pawnIndex;

          movePawn(considerCurrentStep: true);

          break;
        }
      }
    }
  }
}
