import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        enlargeCenterPage: true,
        autoPlay: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/dsa.jpg'),
                          fit: BoxFit.cover)),
                ),
              ));
        });
  }
}
