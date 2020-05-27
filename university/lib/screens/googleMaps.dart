import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class GoogleMaps extends StatefulWidget {
  static const LatLng _center = LatLng(30.1575, 71.5249) ;

  @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  //Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var geolocator = Geolocator();

  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor,
          //color: Colors.grey,
          child: GoogleMap(
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: GoogleMaps._center,
              zoom: 10.0,
            ),
          ),
        ),
        Positioned(
          top: 60,
          right: 15,
          left: 15,
          child: Card(
            child: Row(
              children: <Widget>[
//                IconButton(
//                  splashColor: Colors.grey,
//                  icon: Icon(Icons.menu),
//                  onPressed: () {},
//                ),
                Expanded(
                  child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search..."),
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(right: 8.0),
//                  child: CircleAvatar(
//                    backgroundColor: Colors.deepPurple,
//                    child: Text('RD'),
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
