// ignore_for_file: camel_case_types

import 'package:get/state_manager.dart';

class carouselIndex extends GetxController {
  RxInt currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
  }
}

class bottomNavigationIndex extends GetxController {
  RxInt currentIndex = 0.obs;
  void setIndex(int index) {
    currentIndex.value = index;
  }
}

class locationcon extends GetxController {
  RxString currentLocationstreet = "".obs;
  void setlocation(String street) {
    currentLocationstreet.value = street;
  }
}

class locationLoading extends GetxController {
  RxBool isloading = false.obs;
  void setLoading(bool loading) {
    isloading.value = loading;
  }
  
}