import 'package:flutter/cupertino.dart';

class NavigationBarModel with ChangeNotifier {
  bool isOpen = false;

  set navigationBar(value) {
    isOpen = value;
    notifyListeners();
  }

  get navigationBar {
    return isOpen;
  }
}
