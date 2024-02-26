import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/result/functions/draw_rank.dart';

class DrawingResult extends CustomPainter {
  final List<int> ranksList;

  DrawingResult(this.ranksList);

  @override
  void paint(Canvas canvas, Size size) {
    var stepSize = size.width / 15;
    var homeStartOffset = stepSize * 9;
    var homeSize = stepSize * 6;

    for (int playerIndex = 0; playerIndex < ranksList.length; playerIndex++) {
      var rank = ranksList[playerIndex];
      if (rank != 0) {
        double left, top;
        switch (playerIndex) {
          case 0:
            left = 0;
            top = 0;
            break;
          case 1:
            left = homeStartOffset;
            top = 0;
            break;
          case 2:
            left = homeStartOffset;
            top = homeStartOffset;
            break;
          default:
            left = 0;
            top = homeStartOffset;
        }
        drawRank(canvas, Rect.fromLTWH(left, top, homeSize, homeSize), rank);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  @override
  bool hitTest(Offset position) => false;
}
