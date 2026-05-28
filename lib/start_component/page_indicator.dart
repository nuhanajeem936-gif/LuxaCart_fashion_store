import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Indicator extends StatelessWidget {
  final PageController controller;

  const Indicator({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 2,
      effect: ExpandingDotsEffect(
        expansionFactor: 3,
        spacing: 8,
        radius: 20,
        dotHeight: 8,
        dotWidth: 8,
        dotColor: Colors.grey.shade300,
        activeDotColor: const Color(0xFFF06292),
      ),
    );
  }
}
