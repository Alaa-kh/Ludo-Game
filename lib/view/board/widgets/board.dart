import 'package:flutter_application_2/core/constants/app_packages.dart';

class PaintBoard extends CustomPainter {
  Function(List<List<List<Rect>>>)? trackListener;

  PaintBoard({@required this.trackListener});

  double? stepSize;
  double? homeStartOffset;
  double? homeSize;
  double? canvasCenter;
  List<List<Offset>> homeSpotsList = [];
  List<Rect> playerOneTrack = [];

  Paint fillPaint = Paint()..style = PaintingStyle.fill;
  Paint strokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.2
    ..color = AppColors.blackColor;

  @override
  void paint(Canvas canvas, Size size) {
    stepSize = size.width / 15.0;
    homeStartOffset = stepSize! * 9.0;
    homeSize = stepSize! * 6.0;
    canvasCenter = size.width / 2.0;

    drawHome(canvas, size);
    drawDestination(canvas, size);
    drawSteps(canvas, size);
    calculatePlayerTracks();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void calculatePlayerTracks() {
    Rect? prevRect;
    Offset? prevOffset;

//------------------------------------ Player 1 Track ------------------------------------

    for (int stepIndex = 0; stepIndex < 57; stepIndex++) {
      if (stepIndex == 0) {
        var offset = stepSize! / 2;
        prevOffset = Offset(stepSize! + offset, homeSize! + offset);
      } else if (stepIndex < 5 ||
          stepIndex > 50 ||
          stepIndex > 18 && stepIndex < 24 ||
          stepIndex > 10 && stepIndex < 13)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset =
            Offset(prevRect!.center.dx + stepSize!, prevRect.center.dy);
      else if (stepIndex == 5)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset = Offset(
            prevRect!.center.dx + stepSize!, prevRect.center.dy - stepSize!);
      else if (stepIndex < 11 ||
          stepIndex > 38 && stepIndex < 44 ||
          stepIndex == 50)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset =
            Offset(prevRect!.center.dx, prevRect.center.dy - stepSize!);
      else if (stepIndex < 18 ||
          stepIndex > 31 && stepIndex < 37 ||
          stepIndex > 18 && stepIndex < 26)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset =
            Offset(prevRect!.center.dx, prevRect.center.dy + stepSize!);
      else if (stepIndex == 18)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset = Offset(
            prevRect!.center.dx + stepSize!, prevRect.center.dy + stepSize!);
      else if (stepIndex < 31 ||
          stepIndex > 31 && stepIndex < 39 ||
          stepIndex > 44 && stepIndex < 50)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset =
            Offset(prevRect!.center.dx - stepSize!, prevRect.center.dy);
      else if (stepIndex == 31)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset = Offset(
            prevRect!.center.dx - stepSize!, prevRect.center.dy + stepSize!);
      else if (stepIndex == 44)
        // ignore: curly_braces_in_flow_control_structures
        prevOffset = Offset(
            prevRect!.center.dx - stepSize!, prevRect.center.dy - stepSize!);

      prevRect = Rect.fromCenter(
          center: prevOffset!, width: stepSize!, height: stepSize!);
      playerOneTrack.add(prevRect);
    }

//------------------------------------ Player 2 Track ------------------------------------

    List<Rect> playerTwoTrack = [];

    playerTwoTrack.addAll(playerOneTrack.sublist(13, 51));
    prevRect = playerTwoTrack.last;
    playerTwoTrack.add(Rect.fromCenter(
        center: Offset(prevRect.center.dx, prevRect.center.dy - stepSize!),
        width: stepSize!,
        height: stepSize!));
    playerTwoTrack.addAll(playerOneTrack.sublist(0, 12));

    for (int stepIndex = 0; stepIndex < 6; stepIndex++) {
      prevRect = playerTwoTrack.last;
      playerTwoTrack.add(Rect.fromCenter(
          center: Offset(prevRect.center.dx, prevRect.center.dy + stepSize!),
          width: stepSize!,
          height: stepSize!));
    }

    //------------------------------------ Player 3 Track ------------------------------------

    List<Rect> playerThreeTrack = [];

    playerThreeTrack.addAll(playerTwoTrack.sublist(13, 51));
    prevRect = playerThreeTrack.last;
    playerThreeTrack.add(Rect.fromCenter(
        center: Offset(prevRect.center.dx + stepSize!, prevRect.center.dy),
        width: stepSize!,
        height: stepSize!));
    playerThreeTrack.addAll(playerTwoTrack.sublist(0, 12));

    for (int stepIndex = 0; stepIndex < 6; stepIndex++) {
      prevRect = playerThreeTrack.last;
      playerThreeTrack.add(Rect.fromCenter(
          center: Offset(prevRect.center.dx - stepSize!, prevRect.center.dy),
          width: stepSize!,
          height: stepSize!));
    }

    //------------------------------------ Player 4 Track ------------------------------------

    List<Rect> playerFourTrack = [];

    playerFourTrack.addAll(playerThreeTrack.sublist(13, 51));
    prevRect = playerFourTrack.last;
    playerFourTrack.add(Rect.fromCenter(
        center: Offset(prevRect.center.dx, prevRect.center.dy + stepSize!),
        width: stepSize!,
        height: stepSize!));
    playerFourTrack.addAll(playerThreeTrack.sublist(0, 12));

    for (int stepIndex = 0; stepIndex < 6; stepIndex++) {
      prevRect = playerFourTrack.last;
      playerFourTrack.add(Rect.fromCenter(
          center: Offset(prevRect.center.dx, prevRect.center.dy - stepSize!),
          width: stepSize!,
          height: stepSize!));
    }

    //------------------------------------ Add Spots With Tracks ------------------------------------

    List<List<List<Rect>>> playerTracks = [];

    for (int playerIndex = 0; playerIndex < 4; playerIndex++) {
      List<List<Rect>> playerTrack = [];

      for (int spotIndex = 0;
          spotIndex < homeSpotsList[playerIndex].length;
          spotIndex++) {
        List<Rect> track = [];

        track.add(Rect.fromCenter(
            center: homeSpotsList[playerIndex][spotIndex],
            width: stepSize!,
            height: stepSize!));

        switch (playerIndex) {
          case 0:
            track.addAll(playerOneTrack);
            break;
          case 1:
            track.addAll(playerTwoTrack);
            break;
          case 2:
            track.addAll(playerThreeTrack);
            break;
          case 3:
            track.addAll(playerFourTrack);
            break;
          default:
        }

        playerTrack.add(track);
      }
      playerTracks.add(playerTrack);
    }

    trackListener!(playerTracks);
  }

  //------------------------------------ Draw Home ------------------------------------
  void drawHome(Canvas canvas, Size size) {
    // Draw home base

    fillPaint.color = AppColors.greenAccentColor;
    var greenSquare = Rect.fromLTWH(0, 0, homeSize!, homeSize!);
    canvas.drawRect(greenSquare, fillPaint);
    canvas.drawRect(greenSquare, strokePaint);

    fillPaint.color = AppColors.redAccentColor;
    var redSquare = Rect.fromLTWH(homeStartOffset!, 0, homeSize!, homeSize!);
    canvas.drawRect(redSquare, fillPaint);
    canvas.drawRect(redSquare, strokePaint);

    fillPaint.color = AppColors.blueAccentColor;
    var blueSquare =
        Rect.fromLTWH(homeStartOffset!, homeStartOffset!, homeSize!, homeSize!);
    canvas.drawRect(blueSquare, fillPaint);
    canvas.drawRect(blueSquare, strokePaint);

    fillPaint.color = AppColors.yellowAccentColor;
    var yellowSquare = Rect.fromLTWH(0, homeStartOffset!, homeSize!, homeSize!);
    canvas.drawRect(yellowSquare, fillPaint);
    canvas.drawRect(yellowSquare, strokePaint);

    // Draw inner home

    var innerHomeSize = homeSize! - 2 * stepSize!;

    fillPaint.color = AppColors.whiteColor;
    var innerHomeOne = Rect.fromLTWH(greenSquare.left + stepSize!,
        greenSquare.top + stepSize!, innerHomeSize, innerHomeSize);
    canvas.drawRect(innerHomeOne, fillPaint);
    canvas.drawRect(innerHomeOne, strokePaint);

    var innerHomeTwo = Rect.fromLTWH(redSquare.left + stepSize!,
        redSquare.top + stepSize!, innerHomeSize, innerHomeSize);
    canvas.drawRect(innerHomeTwo, fillPaint);
    canvas.drawRect(innerHomeTwo, strokePaint);

    var innerHomeThree = Rect.fromLTWH(blueSquare.left + stepSize!,
        blueSquare.top + stepSize!, innerHomeSize, innerHomeSize);
    canvas.drawRect(innerHomeThree, fillPaint);
    canvas.drawRect(innerHomeThree, strokePaint);

    var innerHomeFour = Rect.fromLTWH(yellowSquare.left + stepSize!,
        yellowSquare.top + stepSize!, innerHomeSize, innerHomeSize);
    canvas.drawRect(innerHomeFour, fillPaint);
    canvas.drawRect(innerHomeFour, strokePaint);

    // Draw spawn spots

    drawSpawnSpots(canvas, innerHomeOne, AppColors.greenAccentColor);
    drawSpawnSpots(canvas, innerHomeTwo, AppColors.redAccentColor);
    drawSpawnSpots(canvas, innerHomeThree, AppColors.blueAccentColor);
    drawSpawnSpots(canvas, innerHomeFour, AppColors.yellowAccentColor);
  }

//------------------------------------ Draw Spawn Spots ------------------------------
  void drawSpawnSpots(Canvas canvas, Rect homeInner, Color color) {
    List<Offset> spotList = [];

    fillPaint.color = color;
    var spotOffsetOne = homeInner.width / 4;
    var spotOffsetTwo = 3 * spotOffsetOne;
    double spotRadius = spotOffsetOne / 2;

    canvas.save();
    canvas.translate(homeInner.left, homeInner.top);

    var spot1 = Offset(spotOffsetOne, spotOffsetOne);
    canvas.drawCircle(spot1, spotRadius, fillPaint);
    canvas.drawCircle(spot1, spotRadius, strokePaint);

    var spot2 = Offset(spotOffsetTwo, spotOffsetOne);
    canvas.drawCircle(spot2, spotRadius, fillPaint);
    canvas.drawCircle(spot2, spotRadius, strokePaint);

    var spot3 = Offset(spotOffsetOne, spotOffsetTwo);
    canvas.drawCircle(spot3, spotRadius, fillPaint);
    canvas.drawCircle(spot3, spotRadius, strokePaint);

    var spot4 = Offset(spotOffsetTwo, spotOffsetTwo);
    canvas.drawCircle(spot4, spotRadius, fillPaint);
    canvas.drawCircle(spot4, spotRadius, strokePaint);

    canvas.restore();

// Spots coordinate calculation

    var left = homeInner.left + spotOffsetOne;
    var right = homeInner.left + spotOffsetTwo;
    var up = homeInner.top + spotOffsetOne;
    var down = homeInner.top + spotOffsetTwo;

    spotList.add(Offset(left, up));
    spotList.add(Offset(right, up));
    spotList.add(Offset(right, down));
    spotList.add(Offset(left, down));

    homeSpotsList.add(spotList);
  }

//------------------------------------ Draw Destination ------------------------------
  void drawDestination(Canvas canvas, Size size) {
    fillPaint.color = AppColors.greenAccentColor;
    var greenDestination = Path()
      ..moveTo(canvasCenter!, canvasCenter!)
      ..lineTo(homeSize!, homeStartOffset!)
      ..lineTo(homeSize!, homeSize!)
      ..close();
    canvas.drawPath(greenDestination, fillPaint);
    canvas.drawPath(greenDestination, strokePaint);

    fillPaint.color = AppColors.redAccentColor;
    var redDestination = Path()
      ..moveTo(canvasCenter!, canvasCenter!)
      ..lineTo(homeSize!, homeSize!)
      ..lineTo(homeStartOffset!, homeSize!)
      ..close();
    canvas.drawPath(redDestination, fillPaint);
    canvas.drawPath(redDestination, strokePaint);

    fillPaint.color = AppColors.blueAccentColor;
    var blueDestination = Path()
      ..moveTo(canvasCenter!, canvasCenter!)
      ..lineTo(homeStartOffset!, homeSize!)
      ..lineTo(homeStartOffset!, homeStartOffset!)
      ..close();
    canvas.drawPath(blueDestination, fillPaint);
    canvas.drawPath(blueDestination, strokePaint);

    fillPaint.color = AppColors.yellowAccentColor;
    var yellowDestination = Path()
      ..moveTo(canvasCenter!, canvasCenter!)
      ..lineTo(homeSize!, homeStartOffset!)
      ..lineTo(homeStartOffset!, homeStartOffset!)
      ..close();
    canvas.drawPath(yellowDestination, fillPaint);
    canvas.drawPath(yellowDestination, strokePaint);
  }

//------------------------------------ Draw Steps ------------------------------------
  void drawSteps(Canvas canvas, Size size) {
    double verticalOffset;

    var arrowPaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int homeIndex = 0; homeIndex < 4; homeIndex++) {
      verticalOffset = homeSize!;
      switch (homeIndex) {
        case 0:
          fillPaint.color = AppColors.greenAccentColor;
          break;
        case 1:
          fillPaint.color = AppColors.redAccentColor;
          break;
        case 2:
          fillPaint.color = AppColors.blueAccentColor;
          break;
        default:
          fillPaint.color = AppColors.yellowAccentColor;
          break;
      }

      for (int i = 0; i < 6; i++) {
        var unit =
            Rect.fromLTWH(i * stepSize!, verticalOffset, stepSize!, stepSize!);

        if (i == 1) canvas.drawRect(unit, fillPaint);

        canvas.drawRect(unit, strokePaint);
      }

      verticalOffset += stepSize!;
      for (int j = 0; j < 6; j++) {
        var unit =
            Rect.fromLTWH(j * stepSize!, verticalOffset, stepSize!, stepSize!);

        if (j > 0) {
          canvas.drawRect(unit, fillPaint);
        } else {
          var arrowPadding = unit.width / 4;
          var arrowWingGap = arrowPadding / 1.5;
          var arrowTip =
              Offset(unit.right - arrowPadding, unit.bottom - unit.height / 2);
          arrowPaint.color = fillPaint.color;

          canvas.drawPath(
              Path()
                ..moveTo(unit.left + arrowPadding, arrowTip.dy)
                ..lineTo(arrowTip.dx, arrowTip.dy)
                ..lineTo(arrowTip.dx - arrowWingGap, arrowTip.dy - arrowWingGap)
                ..moveTo(arrowTip.dx - arrowWingGap, arrowTip.dy + arrowWingGap)
                ..lineTo(arrowTip.dx, arrowTip.dy),
              arrowPaint);
        }

        canvas.drawRect(unit, strokePaint);
      }

      verticalOffset += stepSize!;
      for (int k = 0; k < 6; k++) {
        var unit =
            Rect.fromLTWH(k * stepSize!, verticalOffset, stepSize!, stepSize!);

        if (k == 2) {
          var safeSpotRadius = stepSize! / 4;
          fillPaint.color = AppColors.safeSpotColor;
          canvas.drawCircle(unit.center, safeSpotRadius, fillPaint);
          canvas.drawCircle(unit.center, safeSpotRadius, strokePaint);
        }

        canvas.drawRect(unit, strokePaint);
      }

      canvas.translate(canvasCenter!, canvasCenter!);
      canvas.rotate(pi / 2);
      canvas.translate(-canvasCenter!, -canvasCenter!);
    }
  }
}
