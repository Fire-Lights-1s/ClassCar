import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget imgIndicator({
  required List<dynamic> imgURL,
  required CarouselController controller,
  required int currentImgIdx,
}) {
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

Widget imgSlider({
  required List<dynamic> imgURL,
  // ignore: use_function_type_syntax_for_parameters
  required Function onChanged(index),
}) {
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
