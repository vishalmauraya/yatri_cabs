import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State provider for the active slider index
final sliderIndexProvider = StateProvider<int>((ref) => 0);

class AdSlider extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(sliderIndexProvider);

    // Slider content list
    final List<Map<String, String>> sliderData = [
      {
        "image": "assets/images/adds.png", // Replace with your asset/image URL
      },
      {
        "image": "assets/images/adds.png", // Replace with your asset/image URL
      },
      {
        "image": "assets/images/adds.png", // Replace with your asset/image URL
      },
    ];

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.95,
        child: Stack(
          children: [
            CarouselSlider(
              items: sliderData.map((data) {
                return Builder(
                  builder: (context) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(data["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200.0,

                autoPlay: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  ref.read(sliderIndexProvider.notifier).state = index;
                },
              ),
            ),

            // Dots Indicator on Top of Image
            Positioned(
              bottom: 10, // Positioned near the bottom of the slider
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: sliderData.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () =>
                    ref.read(sliderIndexProvider.notifier).state = entry.key,
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (currentIndex == entry.key
                            ? const Color(0xff38b000) // Active indicator color
                            : Colors.black), // Inactive indicator color
                      ),
                    ),
                  );
                }).toList(),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
