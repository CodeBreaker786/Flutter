import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Genrate extends StatefulWidget {
  @override
  _GenrateState createState() => _GenrateState();
}

TextEditingController textEditingController = TextEditingController();
Image image;

class _GenrateState extends State<Genrate> {
  String data = 'No Data';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genrate QR Code'),
      ),
      body: Center(child: Text(data)),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final _prefs = await SharedPreferences.getInstance();

        //await _prefs.setString('tenatName', "tenantName");
        var result = await _prefs.getString('tenatName');
        print(result);
        setState(() {
          data = result;
        });
      }),
    );
  }
}
