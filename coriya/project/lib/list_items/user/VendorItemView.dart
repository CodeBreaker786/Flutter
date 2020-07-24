import 'package:avalinks/models/vendor/VendorData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VendorItemView extends StatelessWidget {
  VendorData data;

  VendorItemView(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: data == null
            ? new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("Loading"),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${data.first_name} ${data.last_name}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Email : ',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Flexible(
                          child: InkWell(
                            child: Text(
                              data.user_email,
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              launch('mailto:${data.user_email}');
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Phone : ',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Flexible(
                          child: InkWell(
                            child: Text(
                              data.user_phone,
                              style: TextStyle(color: Colors.blue),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              launch('tel:${data.user_phone}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
