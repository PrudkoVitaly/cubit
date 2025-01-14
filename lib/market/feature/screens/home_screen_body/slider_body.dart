import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  const MySlider({super.key});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final List<String> imgList = [
    // "images/slider_img_2.png",
    // "images/slider_img_1.1.png",
    // "images/slider_img_3.png",
    "images/slider_img_1.1.png",
    "images/slider_img_1.1.png",
    "images/slider_img_1.1.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: CarouselSlider(
          items: imgList
              .map((e) => Center(
                    child: Container(
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(e), // Используй Image.asset вместо Image.network
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            height: 170,
            autoPlay: false,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
          ),
        ),
      ),
    );
  }
}
