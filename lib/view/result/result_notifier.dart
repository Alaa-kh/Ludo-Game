import 'package:flutter/material.dart';

class ResultNotifier with ChangeNotifier {
  final List<int> _ranksList = [0, 0, 0, 0];

  get ranks => _ranksList;

  void rebuildPaint(int winnerPlayerIndex) {
    var nextRank = 0;

    for (var rank in _ranksList) {
      if (rank > nextRank) nextRank = rank;
    }
    _ranksList[winnerPlayerIndex] = ++nextRank;

    if (nextRank == 3) {
      _ranksList[_ranksList.indexWhere((rank) {
        return rank == 0;
      })] = 4;
    }

    notifyListeners();
  }
}
