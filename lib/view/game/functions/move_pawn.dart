import 'package:flutter_application_2/core/constants/app_packages.dart';

void movePawn({bool considerCurrentStep = false}) {
  int playerIndex, pawnIndex, currentStepIndex;

  if (collisionDetails!.isReverse) {
    playerIndex = collisionDetails!.targetPlayerIndex!;
    pawnIndex = collisionDetails!.pawnIndex!;
    currentStepIndex = max(
        pawnCurrentStepInfoList[playerIndex][pawnIndex].key -
            (considerCurrentStep ? 0 : 1),
        0);
  } else {
    playerIndex = currentTurn;
    pawnIndex = selectedPawnIndex;
    currentStepIndex = min(
        pawnCurrentStepInfoList[playerIndex][pawnIndex].key +
            (considerCurrentStep ? 0 : 1),
        maxTrackIndex);
  }

  // update current step info in the [pawnCurrentStepInfoList] list
  var currentStepInfo = MapEntry(currentStepIndex,
      playerTracksList![playerIndex][pawnIndex][currentStepIndex]);
  pawnCurrentStepInfoList[playerIndex][pawnIndex] = currentStepInfo;

  var animCont = playerAnimationContList[playerIndex][pawnIndex];

  if (collisionDetails!.isReverse) {
    if (currentStepIndex > 0) {
      // animate one step reverse
      playerAnimationList[collisionDetails!.targetPlayerIndex!]
          [collisionDetails!.pawnIndex!] = Tween(
              begin: currentStepInfo.value.center,
              end: playerTracksList![collisionDetails!.targetPlayerIndex!]
                      [collisionDetails!.pawnIndex!][currentStepIndex - 1]
                  .center)
          .animate(animCont);
      animCont.forward(from: 0.0);
    } else {
      playerAnimationContList[playerIndex][pawnIndex].duration =
          Duration(milliseconds: forwardStepAnimTimeInMillis);
      collisionDetails!.isReverse = false;
      provideFreeTurn = true;
      alterTurn();
    }
  } else if (stepCounter != diceOutput) {
    // animate one step forward
    playerAnimationList[playerIndex][pawnIndex] = Tween(
            begin: currentStepInfo.value.center,
            end: playerTracksList![playerIndex][pawnIndex]
                    [min(currentStepIndex + 1, maxTrackIndex)]
                .center)
        .animate(CurvedAnimation(
            parent: animCont,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic)));
    animCont.forward(from: 0.0);
  } else {
    if (verifyCollision(currentStepInfo)) {
      movePawn(considerCurrentStep: true);
    } else {
      if (currentStepIndex == maxTrackIndex) {
        winnerPawnList[currentTurn]
            .add(selectedPawnIndex); //add pawn to [winnerPawnList]

        if (winnerPawnList[currentTurn].length < 4) {
          provideFreeTurn =
              true; //if player has remaining pawns, provide free turn for reaching destination
        } else {
          resultNotifier!.rebuildPaint(currentTurn);
          provideFreeTurn =
              false; //to discard free turn if he completes the game
        }
      }

      alterTurn();
    }
  }
}
