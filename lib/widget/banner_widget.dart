import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_project/util/screen_adapter_helper.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  final List<String> bannerList;
  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 160.px,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          carouselController: _controller,
          items:
              widget.bannerList.map((item) => _tabImage(item, width)).toList(),
        ),
        Positioned(
          bottom: 10.px,
          right: 0,
          left: 0,
          child: _indicator(),
        ),
      ],
    );
  }

  Widget _tabImage(String imgUrl, double width) {
    return GestureDetector(
      onTap: () {
        // 点击banner跳转
      },
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
        width: width,
      ),
    );
  }

  _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.bannerList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 8.px,
            height: 8.px,
            margin: EdgeInsets.symmetric(horizontal: 5.px, vertical: 8.px),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == entry.key
                  ? Colors.blue
                  : Colors.grey.withOpacity(0.5),
            ),
          ),
        );
      }).toList(),
    );
  }
}
