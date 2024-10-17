import 'package:contactapp/viewmodel/common_controller.dart';
import 'package:contactapp/views/home_screen.dart';
import 'package:contactapp/views/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class Navigatorscreen extends StatefulWidget {
  const Navigatorscreen({super.key});

  @override
  State<Navigatorscreen> createState() => _NavigatorscreenState();
}

class _NavigatorscreenState extends State<Navigatorscreen> {

  List <Widget> screens = [
    const HomeScreen(),
    const SearchScreen()
  ];
  final bottomNavigationIndex navigationIndex = Get.put(bottomNavigationIndex());

  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[navigationIndex.currentIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: Obx(() {
            return BottomNavigationBar(
              currentIndex: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (value) {
                navigationIndex.setIndex(value);
              },
              items:  [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled, color: navigationIndex.currentIndex.value == 0 ? Colors.green : Colors.black),
                    label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search_rounded,
                      color: navigationIndex.currentIndex.value == 1 ? Colors.green : Colors.black
                    ),
                    label: "Search"),
                // BottomNavigationBarItem(icon: Icon(Icons.pageview_outlined,color :Colors.black),label: "Search"),
                // BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined,color :Colors.black),label: "Profile"),
              ]);
          })
        ),
      ),
    );
  }
}