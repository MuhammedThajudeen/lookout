// ignore_for_file: camel_case_types

import 'package:contactapp/utils/common_functions.dart';
import 'package:contactapp/utils/common_widgets.dart';
import 'package:contactapp/utils/constants.dart';
import 'package:contactapp/viewmodel/common_controller.dart';
import 'package:contactapp/views/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class categoryScreen extends StatefulWidget {
  const categoryScreen({super.key, required this.categoryImage});
  final String categoryImage;

  @override
  State<categoryScreen> createState() => _categoryScreenState();
}

class _categoryScreenState extends State<categoryScreen> {
  @override
  Widget build(BuildContext context) {
    final locationcon loc = Get.put(locationcon());
    return Scaffold(
      backgroundColor: const Color(0xFFCFE4D6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
          child: Column(
            children: [
              topRow(),
              const SizedBox(
                height: 30,
              ),
              courouselSlider(),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return Wrap(
                  children: [
                    const Text(
                      'Top ',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Text(
                      'Dealers around ',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      loc.currentLocationstreet.value != ''
                          ? loc.currentLocationstreet.value
                          : 'Unknown',
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xff117633)),
                    )
                  ],
                );
              }),
              // const Text(
              //   'Top Resturents Dealers in Perambra, Kozhikode',
              //   style: TextStyle(color: Color(0xff117633), fontSize: 15),
              // ),
              const SizedBox(
                height: 15,
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 5, top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.longestSide *
                                        0.10,
                                width: MediaQuery.of(context).size.longestSide *
                                    0.10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.asset(widget.categoryImage),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'White House Resturent Wayanad',
                                      style: TextStyle(
                                          overflow: TextOverflow.clip,
                                          fontFamily: "Lato",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        openMap(locationCoordinates["lat"], locationCoordinates["lng"]);
                                      },
                                      child:  const Row(
                                        children: [
                                          Icon(FontAwesomeIcons.mapLocation, size: 12, color: Colors.black54,),
                                          SizedBox(width: 5,),
                                          Text(
                                            'Location',
                                            style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.black,
                                                fontFamily: "Lato",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Row(
                                      children: [
                                        iconButton(
                                            onPressed: () {
                                              _makePhoneCall('8289935986');
                                            },
                                            icon: Icons.call,
                                            text: 'Call Now'),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        iconButton(
                                            onPressed: () {
                                              _openWhatsApp('+918289935986',
                                                  'Hi Thajudeen..😊\nEnquiry about the app');
                                            },
                                            icon: FontAwesomeIcons.whatsapp,
                                            text: 'Chat Now')
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget topRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios,
                    size: 16, color: Color(0xff117633))),
            const Text(
              'Resturents',
              style: TextStyle(
                  color: Color(0xff117633),
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Row(
          children: [
            headerbuttonContainer(
                Icons.notification_important_outlined, Colors.grey.shade300,
                bgcolor: Colors.white, onPressed: () {
              Get.to(() => const NotificationScreen());
            }),
          ],
        )
      ],
    );
  }

  Widget iconButton(
      {required void Function() onPressed,
      required IconData icon,
      required String text}) {
    return InkWell(
      onTap: onPressed,
      child: Icon(
        icon,
        color: const Color(0xff075243),
        size: 18,
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    //  convert url to uri
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open WhatsApp with a message
  void _openWhatsApp(String phoneNumber, String message) async {
    final link = WhatsAppUnilink(
      phoneNumber: phoneNumber,
      text: message,
    );
    // Convert the WhatsAppUnilink instance to a Uri.
    // The "launch" method is part of "url_launcher".
    await launchUrl(link.asUri());
  }
}
