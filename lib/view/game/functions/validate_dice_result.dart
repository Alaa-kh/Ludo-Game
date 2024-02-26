import 'package:flutter_application_2/core/constants/app_packages.dart';

void validityOfDiceResult() {
  var isValid = false;

  for (var stepInfo in pawnCurrentStepInfoList[currentTurn]) {
    if (diceOutput == 6) {
      if (straightSixesCounter == 3) {
        //change turn in case of 3 straight sixes
        break;
      } else if (stepInfo.key + diceOutput >
          maxTrackIndex) //ignore pawn if it can't move 6 steps
        // ignore: curly_braces_in_flow_control_structures
        continue;

      provideFreeTurn = true;
      isValid = true;
      break;
    } else if (stepInfo.key != 0) {
      if (stepInfo.key + diceOutput <= maxTrackIndex) {
        isValid = true;
        break;
      }
    }
  }

  if (!isValid) alterTurn();
}
