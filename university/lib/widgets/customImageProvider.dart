import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:flutter_advanced_networkimage/transition.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget imageViewer(String mediaUrl) {
  return TransitionToImage(
    image: AdvancedNetworkImage(
      mediaUrl,

      // loadingProgress: (double progress) {
      //   print('Now Loading: $progress');
      // },
    ),
    loadingWidgetBuilder: (_, double progress, __) => Container(
      height: 300,
      child: Center(
          child: SpinKitDoubleBounce(
        color: Theme.of(_).accentColor,
      )),
    ),
    fit: BoxFit.cover,
    placeholder: const Icon(Icons.refresh),
    height: 300.0,
    enableRefresh: true,
  );
}
