
import 'package:carousel_slider/carousel_slider.dart';
import 'package:contactapp/viewmodel/common_controller.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';


Widget courouselSlider() {
  final carouselIndex indexcontroller = Get.put(carouselIndex());
    return SizedBox(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CarouselSlider(
                  items:  [
                    Container(
                      color: Colors.black,
                      child: const Center(
                          child: Text(
                        'SHOP ADVERTISEMENT BANNER GOES HERE',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    Container(
                      color: Colors.lightBlue,
                    ),
                    Container(
                      color: Colors.red,
                    )
                  ],
                  options: CarouselOptions(
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      indexcontroller.setIndex(index);
                    },
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 4),
                    enableInfiniteScroll: true,
                  )),
          ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Obx(() => DotsIndicator(
                  dotsCount: 3,
                  position: indexcontroller.currentIndex.value,
                  decorator: const DotsDecorator(
                    color: Colors.white,
                    activeColor: Color(0xFFCFE4D6)
                  ),
                  )))
        ],
      ),
    );
  }

    Widget headerbuttonContainer(IconData icon, Color borderColor,{
    required Color? bgcolor,required void Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          // circular button with dynamic icon
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: bgcolor,
              border: Border.all(color: borderColor, width: 2),
              borderRadius: BorderRadius.circular(100)),
          child: Center(
              child: Icon(
            icon,
            size: 20,
          ))),
    );
  }