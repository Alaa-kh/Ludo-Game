import 'package:flutter_application_2/core/constants/app_packages.dart';

bool verifyCollision(MapEntry<int, Rect> currentStepInfo) {
  var currentStepCenter = currentStepInfo.value.center;

  if (currentStepInfo.key <
      52) //no need to check if the pawn has entered destination lane
  // ignore: curly_braces_in_flow_control_structures
  if (!safeSpotsList!.any((safeSpot) {
    //avoid checking if it has landed on a safe spot
    return safeSpot.contains(currentStepCenter);
  })) {
    List<CollideDetails> collisions = [];
    for (int playerIndex = 0;
        playerIndex < pawnCurrentStepInfoList.length;
        playerIndex++) {
      for (int pawnIndex = 0;
          pawnIndex < pawnCurrentStepInfoList[playerIndex].length;
          pawnIndex++) {
        if (playerIndex != currentTurn ||
            // ignore: curly_braces_in_flow_control_structures
            pawnIndex != selectedPawnIndex) if (pawnCurrentStepInfoList[
                playerIndex][pawnIndex]
            .value
            .contains(currentStepCenter)) {
          collisions.add(CollideDetails()
            ..pawnIndex = pawnIndex
            ..targetPlayerIndex = playerIndex);
        }
      }
    }

    // Check if collision is valid

    if (collisions.isEmpty ||
        collisions.any((collision) {
          return collision.targetPlayerIndex == currentTurn;
        }) ||
        collisions.length > 1) {
      //conditions to no collision and group collisions
      collisionDetails!.isReverse = false;
    } else {
      collisionDetails = collisions.first;
      playerAnimationContList[collisionDetails!.targetPlayerIndex!]
              [collisionDetails!.pawnIndex!]
          .duration = Duration(milliseconds: reverseStepAnimTimeInMillis);

      collisionDetails!.isReverse = true;
    }
  }
  return collisionDetails!.isReverse;
}
