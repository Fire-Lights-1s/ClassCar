import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImgIndicator extends StatelessWidget {
  final List<dynamic> imgURL;
  final CarouselController controller;
  final int currentImgIdx;

  const ImgIndicator({
    super.key,
    required this.imgURL,
    required this.controller,
    required this.currentImgIdx,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: AlignmentDirectional.bottomStart,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imgURL.asMap().entries.map(
          (entry) {
            return GestureDetector(
              onTap: () => controller.animateToPage(entry.key),
              child: Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                      .withAlpha(currentImgIdx == entry.key ? 200 : 50),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class ImgSlider extends StatelessWidget {
  List<dynamic> imgURL;
  Function onChanged;

  ImgSlider({
    super.key,
    required this.imgURL,
    required this.onChanged(index),
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imgURL.map(
        (url) {
          return Builder(
            builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(url),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          onChanged(index);
        },
      ),
    );
  }
}
