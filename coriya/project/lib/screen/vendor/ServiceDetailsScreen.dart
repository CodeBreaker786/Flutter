import 'package:avalinks/models/service/DeleteServiceModel.dart';
import 'package:avalinks/models/service/ServiceData.dart';
import 'package:avalinks/models/service/ServiceMedia.dart';
import 'package:avalinks/screen/vendor/ServiceAddUpdateScreen.dart';
import 'package:avalinks/utils/AppConstant.dart';
import 'package:avalinks/utils/PrefsUtils.dart';
import 'package:avalinks/utils/Utils.dart';
import 'package:avalinks/ws/HttpResponse.dart';
import 'package:avalinks/ws/MyHttpClient.dart';
import 'package:avalinks/ws/UrlUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ServiceDetailsScreen extends StatefulWidget {
  ServiceData data;

  ServiceDetailsScreen(this.data);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ServiceDetailsState();
  }
}

class ServiceDetailsState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.business_name),
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          showDataRawWidget(
              'Service Name : ',
              widget.data.selected_category == null
                  ? ''
                  : widget.data.selected_category.serviceCategoryName),
          showDataRawWidget('Price : ', widget.data.service_price),
          showDataRawWidget('Description : ', widget.data.service_description),
          showDataRawWidget('Address : ', widget.data.service_address),
          showDataRawWidget(
              'Working Time : ', widget.data.service_working_hour),
          showDataRawWidget('Email : ', widget.data.service_email),
          showDataRawWidget('Phone : ', widget.data.service_phone),
          showDataRawWidget('Website : ', widget.data.service_website),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: <Widget>[
                Text(
                  'Media',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                (widget.data.media == null || widget.data.media.length == 0)
                    ? Text('No Media')
                    : GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: widget.data.media.map((ServiceMedia media) {
                          return GridTile(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.black)),
                              child: Utils()
                                  .showImageWithImageLoader(media.media_path),
                            ),
                          );
                        }).toList(),
                      )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: RaisedButton(
              child: Text(
                'Edit Service',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.green,
              onPressed: () async {
                ServiceData serviceData = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => ServiceAddUpdateScreen(
                              serviceData: widget.data,
                            )));
                if (serviceData != null) {
                  widget.data = serviceData;
                  setState(() {});
                }
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: RaisedButton(
              child: Text(
                'Delete Service',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Delete Service'),
                          content: Text(
                              'Are you sure you want to delete this service?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Yes, Delete'),
                              onPressed: () {
                                Navigator.pop(context);
                                deleteService(widget.data);
                              },
                            ),
                            FlatButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget showDataRawWidget(String key, String value) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Text(
            key,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        Flexible(
          flex: 2,
          child: Text(
            value == null ? '' : value,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ),
      ],
    );
  }

  deleteService(ServiceData serviceData) async {
    String userId = await PrefsUtils.getStringPreference(AppConstant.USER_ID);
    var data = {'user_id': userId, 'service_id': serviceData.service_id};
    HttpResponse httpResponse =
        await MyHttpClient(context).post(UrlUtils.DELETE_SERVICE, data);
    if (httpResponse.success) {
      DeleteServiceModel model =
          DeleteServiceModel.fromJsonMap(httpResponse.response);
      if (model.status == 1) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Delete Service'),
                  content: Text(model.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                ));
      } else {
        Utils().showMessageDialog(context, model.message, httpResponse.error);
      }
    } else {
      Utils().showMessageDialog(context, 'Delete Service', httpResponse.error);
    }
  }
}
