import 'package:flutter/material.dart';

class practice extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("practice"),
    ));
  }
}
//CarouselSlider.builder(
//autoPlay: true,
//itemCount: 10,
//itemBuilder: (context, index) {
//return Padding(
//padding: const EdgeInsets.all(4.0),
//child: Card(
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(12.0),
//),
//clipBehavior: Clip.antiAlias,
//elevation: 10,
//child: Container(
//decoration: BoxDecoration(
//image: DecorationImage(
//image: CachedNetworkImageProvider(
//"https://images.unsplash.com/photo-1584351839586-0529fe9583f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2691&q=80"),
//fit: BoxFit.cover)),
//),
//));
//}),
