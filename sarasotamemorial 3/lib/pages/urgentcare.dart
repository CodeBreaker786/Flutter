 

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sarasotamemorial/model/info.dart';
import 'package:sarasotamemorial/model/locationitem.dart';
 
 
import 'package:sarasotamemorial/widgets/appsettings.dart';
 
import 'package:sarasotamemorial/widgets/ualabel.dart';
import 'package:permission_handler/permission_handler.dart' as p;
import '../navigation.dart';
import '../uatheme.dart';
import 'locationdetails.dart';
 
 

class UrgentCare extends StatefulWidget {
  @override
  _UrgentCareState createState() => _UrgentCareState();
}

class _UrgentCareState extends State<UrgentCare> {
   List<LocationItem> list = new List();
  double latitude;
  double longitude;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await getLocation();
    setData();
    setState(() {
      list.sort((a, b) => Comparable.compare(
          double.parse(a.distance), double.parse(b.distance)));
      ;
      isLoading = false;
    });
  }

  checkPermission() async {
    p.PermissionStatus permission = await p.PermissionHandler()
        .checkPermissionStatus(p.PermissionGroup.locationAlways);
    if (permission == p.PermissionStatus.granted) {
      await getLocation();
      return true;
    } else
      return false;
  }

  getLocation() async {
    var location = new Location();
    bool enabled = await location.serviceEnabled();
    if (enabled) {
      try {
        LocationData locationData = await location.getLocation();
        latitude = locationData.latitude;
        longitude = locationData.longitude;
        print("HERE");
        print(latitude.toString());
        print(longitude.toString());
      } on Exception {
        latitude = 0;
        longitude = 0;
        print("EXCEPTION");
        print(latitude.toString());
        print(longitude.toString());
      }
    } else {
      bool gotEnabled = await location.requestService();
      if (gotEnabled) {
        await getLocation();
      } else {
        latitude = 0;
        longitude = 0;
      }
    }
  }

  String calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return (12742 * asin(sqrt(a))).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    UATheme.init(context);
    if (isLoading)
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    else
      return Scaffold(
        appBar: AppBar(
          title: UALabel(
            text: 'Our Locations',
            size:  20,
          ),
        ),
        body: ListView.builder(
            itemCount: 18,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
         
                   Navigation.open(
                    context,
                    LocationDetails(
                      info: list[i],
                      distance: list[i].distance != null
                          ? '${list[i].distance} mi'
                          : '',
                      latitude: list[i].latitude,
                      longitude: list[i].longitude,
                      address:Info.mapAddress[i],
                    ),
                  );
                },
                title: UALabel(
                  paddingTop: 15,
                  paddingLeft: 10,
                  text: list[i].title,
                  color: Colors.grey.shade500,
                  bold: true,
                ),
                subtitle: UALabel(
                  paddingLeft: 10,
                  paddingTop: 10,
                  paddingBottom: 15,
                  text:
                      list[i].distance != null ? '${list[i].distance} mi' : '',
                  color: AppSettings.primaryColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.green,
                ),
              );
            }),
      );
  }

  setData() {
    list = new List();
    for (int i = 0; i < 18; i++) {
      LocationItem serviceItem = new LocationItem();
      serviceItem.title = Info.title[i];
      serviceItem.url = Info.url[i];
      serviceItem.description = Info.description[i];
      serviceItem.image = Info.image[i];
      serviceItem.address = Info.address[i];
      serviceItem.latitude = Info.latitude[i];
      serviceItem.longitude = Info.longitude[i];
      serviceItem.distance = calculateDistance(
          Info.latitude[i], Info.longitude[i], latitude, longitude);
      list.add(serviceItem);
    }
  }

  line() {
    return Container(
      height: 1,
      color: Colors.grey.shade300,
    );
  }
}
