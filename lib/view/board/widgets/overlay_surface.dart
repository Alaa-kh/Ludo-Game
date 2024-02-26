import 'package:flutter_application_2/core/constants/app_packages.dart';

Rect? home;
final Paint fillPaint = Paint()..style = PaintingStyle.fill;

class CoverArea extends CustomPainter {
  Function(Offset)? clickOffset;
  int? selectedHomeIndex;
  Color? highlightColor;
  CoverArea(
      {@required this.clickOffset,
      @required this.selectedHomeIndex,
      @required this.highlightColor});

  @override
  void paint(Canvas canvas, Size size) {
    var stepSize = size.width / 15;
    var homeStartOffset = stepSize * 9;
    var homeSize = stepSize * 6;

    switch (selectedHomeIndex) {
      case 0:
        home = Rect.fromLTWH(0, 0, homeSize, homeSize);
        break;
      case 1:
        home = Rect.fromLTWH(homeStartOffset, 0, homeSize, homeSize);
        break;
      case 2:
        home =
            Rect.fromLTWH(homeStartOffset, homeStartOffset, homeSize, homeSize);
        break;
      default:
        home = Rect.fromLTWH(0, homeStartOffset, homeSize, homeSize);
    }

    fillPaint.color = highlightColor!;
    canvas.drawRect(home!, fillPaint);
  }

  @override
  bool hitTest(Offset position) {
    clickOffset!(position);
    return true;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
