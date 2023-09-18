import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderScreen extends StatefulWidget {
  const CarouselSliderScreen({super.key});
  @override
  State<CarouselSliderScreen> createState() => _CarouselSliderScreenState();
}

class _CarouselSliderScreenState extends State<CarouselSliderScreen> {
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImages = [
    "https://assets-us-01.kc-usercontent.com/500e0a65-283d-00ef-33b2-7f1f20488fe2/28f462f2-3c85-4a10-9e4d-a35ac97fe2a6/homeOG.png",
    "https://assets.popfun.co.uk/wp-content/uploads/2019/10/20175953/powerrangersbm_show_image.png",
    "https://preview.redd.it/why-wasnt-this-crossover-adapted-to-power-rangers-v0-kldxb91i9tob1.jpg?width=640&crop=smart&auto=webp&s=8682b158193a5739749f785ef201f20e845e5126",
    "https://wallpapercave.com/wp/wp3900433.jpg",
    "https://pm1.aminoapps.com/6970/a36d09fc57aa50df151abf8eef23f677affe0dd7r1-1024-598v2_uhq.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: const Text(
          "Carousel Slider",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(
                    height: 400,
                    viewportFraction: 1,
                    initialPage: 0,
                    reverse: true,
                    autoPlayInterval: const Duration(seconds: 2),
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    })),
            const SizedBox(height: 20),
            builderIndicatior(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      controller.previousPage(
                          duration: const Duration(milliseconds: 500));
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("previous")),
                const SizedBox(width: 13),
                ElevatedButton.icon(
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 500));
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Next")),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget builderIndicatior() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: urlImages.length,
      onDotClicked: animateToSlide,
      effect: const JumpingDotEffect(
          dotWidth: 20,
          dotHeight: 20,
          activeDotColor: Colors.pinkAccent,
          dotColor: Colors.black12),
    );
  }

  animateToSlide(int index) {
    controller.animateToPage(index);
  }
}

Widget buildImage(urlImage, int index) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 17),
    //color: Colors.grey,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );
}
