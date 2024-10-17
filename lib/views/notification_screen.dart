import 'package:contactapp/utils/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCFE4D6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
          child: Column(
            children: [
              topRow(),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.018,
                              horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tileColor: Colors.white,
                          leading: Container(
                            height: 70,
                            width: 70,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Image.network('https://s3-alpha-sig.figma.com/img/a814/f449/1b107d16d5f9268966f05865d50116c6?Expires=1713139200&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=DUVDcgTN94PR4aBWLaOl6hSYzlloAXR9Kjh8bea88XtS44SyyxMY5S7Zs8uwyWC4nAhvpJAWgXozk~9OaA1bXUzF5LdwBEZYKb4sW3T8J2nmZqpAHZ-IRURh~KdjWWLB6RvOr2JCxQ77fc0-AfnVMN6H6aUAtxF36WDibQxScHTBVc1qrA06Avxkcz1Rju4wu-E-W2NQQJa2lw2v28CJw~pbJupGqvSUYWmKW14l4mdl5xZCZZVuyDpXdYsL9c5fxwB0VX8eXkAQBdpWs7h78alsQ80sQm3GXNJSe~thkbmYJB01CRMRXCv3txPfR8z2whrijmVsnz7YtokEkObE3w__',fit: BoxFit.cover,),
                          ),
                          title: const Text('FREE POPCORN (MED) ON A CART VALUE OF 499 OR MORE FRIDAY ONLY.',style: TextStyle(
                            fontSize: 12
                          ),),
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
              'Notifications',
              style: TextStyle(color: Color(0xff117633), fontSize: 15,fontFamily: 'Raleway',fontWeight: FontWeight.w700),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     headerbuttonContainer(Icons.search, Colors.grey.shade300,
        //         bgcolor: Colors.white, onPressed: () {}),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     headerbuttonContainer(
        //         Icons.notification_important_outlined, Colors.grey.shade300,
        //         bgcolor: Colors.white, onPressed: () {}),
        //     const SizedBox(
        //       width: 10,
        //     ),
        //     headerbuttonContainer(Icons.menu, Colors.transparent,
        //         bgcolor: Colors.transparent, onPressed: () {}),
        //   ],
        // )
      ],
    );
  }
}
