import 'package:university/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'navigationScreen.dart';

class Wraper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authication = Provider.of<User>(context);
    if (authication != null) {
      print(authication);
      return NavigationScreen();
    } else {
      return AuthPage();
    }
  }
}
