import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  var longitude = ''.obs;
  var latitude = ''.obs;
  var isLocationEnabeld = false.obs;

  @override
  void onInit() {
    getUserLocation();
    super.onInit();
  }

  getUserLocation() async {
    LocationPermission permission;

    isLocationEnabeld(await Geolocator.isLocationServiceEnabled());
    if (!isLocationEnabeld.value) {
      showDialog(
          response: 'Location is disable',
          onPressed: askPermission(),
          icon: Icons.location_city);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showDialog(
            response: 'Location is denied',
            onPressed: askPermission(),
            icon: Icons.location_city);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showDialog(
          response: 'Location is deniedForever',
          onPressed: askPermission(),
          icon: Icons.location_city);
    }

    if (permission == LocationPermission.always) {
      var position = await Geolocator.getCurrentPosition();
      longitude(position.longitude.toString());
      log(longitude.toString());
      latitude(position.latitude.toString());
      isLocationEnabeld(true);
      showSnackBar('always',
          latitude.value.toString() + longitude.value.toString(), Colors.pink);
    }
    if (permission == LocationPermission.whileInUse) {
      var position = await Geolocator.getCurrentPosition();
      longitude(position.longitude.toString());
      log(longitude.toString());
      latitude(position.latitude.toString());
      isLocationEnabeld(true);
      showSnackBar('while in use ',
          latitude.value.toString() + longitude.value.toString(), Colors.green);
    }
  }

  askPermission() async {
    await Geolocator.requestPermission();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // common snack bar
  showSnackBar(String title, String message, Color backgroundColor) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        colorText: Colors.white,
        duration: Duration(seconds: 2));
  }

  showDialog(
      {IconData? icon,
      Color? color,
      required String response,
      required VoidCallback onPressed}) {
    Get.defaultDialog(
        barrierDismissible: false,
        title: response,
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 60,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                child: TextButton(
                    onPressed: onPressed,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.orangeAccent),
                      overlayColor: MaterialStateProperty.all(Colors.black),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14)),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    child: Text("ask permissioin".tr)),
              ),
            ],
          ),
        ));
  }

  @override
  void onClose() {}
}
