import 'package:avalinks/models/service/ServiceData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceItemView extends StatelessWidget {
  ServiceData data;

  ServiceItemView(this.data);

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
                    data.business_name,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Service : ',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        data.selected_category == null
                            ? ''
                            : data.selected_category.serviceCategoryName,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Price : ',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        data.service_price,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                  Text(data.service_description == null
                      ? ""
                      : data.service_description),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(data.service_address == null
                        ? ""
                        : data.service_address),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Website : ',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Flexible(
                          child: InkWell(
                            child: Text(
                              data.service_website,
                              style: TextStyle(color: Colors.blue),
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () {
                              launch(data.service_website);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Working Hour : ',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          data.service_working_hour,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
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
                                    data.service_email,
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onTap: () {
                                    launch('mailto:${data.service_email}');
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
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
                                    data.service_phone,
                                    style: TextStyle(color: Colors.blue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    launch('tel:${data.service_phone}');
                                  },
                                ),
                              ),
                            ],
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
