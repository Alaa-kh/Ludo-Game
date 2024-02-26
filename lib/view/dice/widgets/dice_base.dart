import 'package:flutter_application_2/core/constants/app_packages.dart';

class DicePainter extends CustomPainter {
  double startAngle;

  DicePainter(this.startAngle);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = size.width;

    var center = Offset(size.width / 2, size.width / 2);
    var acrAngle = 30 * pi / 180;

    for (int arcIndex = 0; arcIndex < 12; arcIndex++) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          acrAngle,
          false,
          Paint()
            ..color = arcIndex % 2 == 0
                ? AppColors.whiteColor
                : AppColors.darkPinkColor
            ..strokeWidth = 5
            ..style = PaintingStyle.stroke);

      startAngle += acrAngle;
    }

    canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = AppColors.purpleColor
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
