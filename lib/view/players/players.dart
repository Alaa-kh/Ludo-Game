import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/constants/app_colors.dart';
import 'package:flutter_application_2/view/players/functions/draw_player_shape.dart';

double? playerSize;
double? playerInnerSize;
double? stepSize;
final Paint playerPaint = Paint()..style = PaintingStyle.fill;
final Paint strokePaint = Paint()
  ..style = PaintingStyle.stroke
  ..strokeWidth = 1.5
  ..color = AppColors.blackColor;

class PlayersPainter extends CustomPainter {
  Offset? playerCurrentSpot;
  Color? playerColor;

  PlayersPainter({
    @required this.playerCurrentSpot,
    @required this.playerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    stepSize = size.width / 15;
    playerSize = stepSize! / 3;
    playerInnerSize = playerSize! / 2.5;

    drawPlayerShape(canvas, playerCurrentSpot!, playerColor!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) => false;
}
