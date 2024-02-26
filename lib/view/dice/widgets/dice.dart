import 'package:flutter_application_2/core/constants/app_packages.dart';

class DicePaint extends CustomPainter {
  final int number;

  DicePaint(this.number);

  @override
  void paint(Canvas canvas, Size size) {
    var dotPaint = Paint()
      ..color = AppColors.whiteColor
      ..style = PaintingStyle.fill;

    var centerComponent = size.width / 2;
    var semiCenterComponent = size.width / 3.5;
    var semiComponent = size.width - size.width / 3.5;
    canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height),
            const Radius.circular(5)),
        Paint()
          ..color = AppColors.whiteColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);

    switch (number) {
      case 1:
        canvas.drawCircle(
            Offset(centerComponent, centerComponent), size.width / 8, dotPaint);
        break;
      case 2:
        var radius = size.width / 10;
        canvas.drawCircle(
            Offset(semiCenterComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiComponent), radius, dotPaint);
        break;
      case 3:
        var radius = size.width / 12;
        canvas.drawCircle(
            Offset(semiCenterComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(centerComponent, centerComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiComponent), radius, dotPaint);
        break;
      case 4:
        var radius = size.width / 10;
        canvas.drawCircle(
            Offset(semiCenterComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiCenterComponent, semiComponent), radius, dotPaint);
        break;
      case 5:
        var radius = size.width / 12;
        canvas.drawCircle(
            Offset(semiCenterComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiCenterComponent, semiComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(centerComponent, centerComponent), radius, dotPaint);
        break;
      case 6:
        var radius = size.width / 15;
        canvas.drawCircle(
            Offset(semiComponent, centerComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiCenterComponent, centerComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiCenterComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiCenterComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiComponent, semiComponent), radius, dotPaint);
        canvas.drawCircle(
            Offset(semiCenterComponent, semiComponent), radius, dotPaint);
        break;
      default:
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
