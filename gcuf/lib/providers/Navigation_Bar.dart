import 'package:flutter/cupertino.dart';

class NavigationBottomBar with ChangeNotifier {
  bool isOpen = false;

  set navigationBar(value) {
    isOpen = value;
    notifyListeners();
  }

  bool get navigationBar {
    return isOpen;
  }
}
