import 'package:flutter_application_2/core/constants/app_packages.dart';

class DiceNotifier extends ChangeNotifier {
  bool _isRolled = false;
  int _output = 1;

  get isRolled => _isRolled;
  get output => _output;

  void rollDice() async {
    _isRolled = false;
    var rollCounter = 0;

    do {
      generateOutputAndNotify();
      await Future.delayed(const Duration(milliseconds: 100));
      rollCounter++;
    } while (rollCounter != 5);

    _isRolled = true;
    generateOutputAndNotify();
  }

  void generateOutputAndNotify() {
    _output = 1 + Random().nextInt(6);
    notifyListeners();
  }
}
