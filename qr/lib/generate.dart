import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class Genrate extends StatefulWidget {
  @override
  _GenrateState createState() => _GenrateState();
}

TextEditingController textEditingController = TextEditingController();
Image image;

class _GenrateState extends State<Genrate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genrate QR Code'),
      ),
      body: Column(
        children: <Widget>[
          NetworkGiffyDialog(
              image: Image.network(
                  "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif"),
              title: Text("data")),
          TextField(
            controller: textEditingController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
//        Uint8List result = await scanner
//            .generateBarCode(textEditingController.text);
//        final image = await QrPainter(
//                data: textEditingController.text,
//                color: Colors.black,
//                emptyColor: Colors.white)
//            .toImageData(400);
      }),
    );
  }
}
