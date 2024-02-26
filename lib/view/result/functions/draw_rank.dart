import 'package:flutter/material.dart';
import 'package:flutter_application_2/core/constants/app_colors.dart';
import 'package:flutter_application_2/core/constants/app_theme.dart';
import 'package:flutter_application_2/view/result/functions/get_rank_text.dart';

drawRank(Canvas canvas, Rect rect, int rank) {
  canvas.drawRect(
    rect,
    Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.blackColor54,
  );

  var rankTextPainter = TextPainter(
      text: TextSpan(
        text: rankText(rank),
        style: AppTheme.myTheme.textTheme.titleMedium,
      ),
      textDirection: TextDirection.ltr)
    ..layout();

  rankTextPainter.paint(
      canvas,
      Offset(rect.center.dx - rankTextPainter.width / 2,
          rect.center.dy - rankTextPainter.height / 2));
}
