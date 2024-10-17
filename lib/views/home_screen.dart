import 'package:contactapp/utils/common_functions.dart';
import 'package:contactapp/utils/common_widgets.dart';
import 'package:contactapp/utils/constants.dart';
import 'package:contactapp/utils/location_service.dart';
import 'package:contactapp/viewmodel/common_controller.dart';
import 'package:contactapp/views/category_screen.dart';
import 'package:contactapp/views/notification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final int count = 10;
  final locationcon locationController = Get.put(locationcon());
  final locationLoading loadingController = Get.put(locationLoading());
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    getLocation();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -166,
              left: -134,
              child: Container(
                height: 356,
                width: 362,
                decoration: const BoxDecoration(
                  color: Color(0xFFCFE4D6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            
            GestureDetector(
              onTap: () {
                if (_animationController.isCompleted) {
                  _animationController.reverse();
                }
              },
              child: maincolumn()),
            SlideTransition(
              position: _offsetAnimation, 
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.only(top: 80,),
                  width: 200,
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 237, 253, 243),
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                  ),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text('Hello Thajudeen !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  )
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget maincolumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50,bottom: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(onTap: () async {
                loadingController.setLoading(true);
                await getLocation();
                loadingController.setLoading(false);
              }, child: Obx(() {
                return Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: Colors.blue,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    loadingController.isloading.value
                        ? staggeredDotwaveLoading()
                        : SizedBox(
                          width: 250,
                          child: Text(
                              locationController.currentLocationstreet.value != ''
                                  ? District != ""
                                      ? '${locationController.currentLocationstreet.value},$District'
                                      : locationController
                                          .currentLocationstreet.value
                                  : 'Unknown',
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                        )
                  ],
                );
              })),
              Row(
                children: [
                  headerbuttonContainer(Icons.notification_important_outlined,
                      Colors.grey.shade300, bgcolor: Colors.transparent,
                      onPressed: () {
                    Get.to(() => const NotificationScreen());
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  headerbuttonContainer(Icons.menu, Colors.transparent,
                      bgcolor: Colors.transparent, onPressed: () {
                        if (_animationController.isDismissed) {
                          _animationController.forward();
                        } else {
                          _animationController.reverse();
                        }
                        setState(() {
                          
                        });
                      }),

                ],
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    Text('Hello, ',
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.normal)),
                    Text('Calicut!',
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.bold))
                  ],
                ),
                Wrap(
                  children: [
                    Text('Lets start exploring ',
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.normal)),
                  ],
                )
              ],
            ),
            // child: Text("Hello, Calicut!\nLet's start exploring",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),)
          ),
          const SizedBox(
            height: 30,
          ),
          courouselSlider(),
          const SizedBox(
            height: 30,
          ),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 25, crossAxisSpacing: 10),
            children: [
              category(
                  categoryName: 'Wedding center',
                  categoryImage: 'assets/images/weddingcenter.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/weddingcenter.png',
                        ));
                  }),
              category(
                  categoryName: 'Grocery',
                  categoryImage: 'assets/images/grocery.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/grocery.png',
                        ));
                  }),
              category(
                  categoryName: 'Hospitals',
                  categoryImage: 'assets/images/Hospitals.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/Hospitals.png',
                        ));
                  }),
              category(
                  categoryName: 'Bakery',
                  categoryImage: 'assets/images/bakery.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/bakery.png',
                        ));
                  }),
              category(
                  categoryName: 'Shoes',
                  categoryImage: 'assets/images/shoes.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/shoes.png',
                        ));
                  }),
              category(
                  categoryName: 'Restaurents',
                  categoryImage: 'assets/images/restaurents.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/restaurents.png',
                        ));
                  }),
              category(
                  categoryName: 'Mobile accessories',
                  categoryImage: 'assets/images/mobileaccessories.png',
                  ontapFun: () {
                    return Get.to(() => const categoryScreen(
                          categoryImage: 'assets/images/mobileaccessories.png',
                        ));
                  }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Home Services',
                style: TextStyle(
                    color: Color(0xff117633),
                    overflow: TextOverflow.clip,
                    fontFamily: "Lato",
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              )),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.longestSide * 0.2,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                HomeServices('Cleaning'),
                const SizedBox(width: 15,),
                HomeServices('Plumber'),
                const SizedBox(width: 15,),
                HomeServices('Electrician'),
                const SizedBox(width: 15,),
                HomeServices('Mechanic'),
                const SizedBox(width: 15,),
                HomeServices('Ac repair')
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget category(
      {required String categoryName,
      required String categoryImage,
      required Function() ontapFun}) {
    return InkWell(
      onTap: ontapFun,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.longestSide * 0.1,
              width: 100,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Image.asset(
                categoryImage,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              categoryName,
              style: const TextStyle(
                  fontSize: 10,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  Widget HomeServices(String serviceName) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      width: 130,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // image: DecorationImage(image: AssetImage('assets/images/restaurents.png'),fit: BoxFit.fill)
      ),
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            serviceName,
          )),
    );
  }
}
