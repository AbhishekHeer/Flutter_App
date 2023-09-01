import 'package:flutter/foundation.dart';

class Like with ChangeNotifier {
  final List<int> _Indexx = [];
  List<int> get Idexx => _Indexx;
  void addlike(int value) {
    _Indexx.add(value);
    notifyListeners();
  }
}
