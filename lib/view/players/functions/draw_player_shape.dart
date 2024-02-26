import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/constants/app_colors.dart';
import 'package:flutter_application_2/view/players/players.dart';

void drawPlayerShape(Canvas canvas, Offset offset, Color color) {
  playerPaint.color = color;
  canvas.drawCircle(offset, playerSize!, playerPaint);
  canvas.drawCircle(offset, playerSize!, strokePaint);

  playerPaint.color = AppColors.whiteColor;
  canvas.drawCircle(offset, playerInnerSize!, playerPaint);
  canvas.drawCircle(offset, playerInnerSize!, strokePaint);
}
