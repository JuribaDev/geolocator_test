import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() => controller.isLocationEnabeld.value
            ? Text('latitude: ${controller.latitude.value.toString()} ' +
                'langitude: ${controller.longitude.value.toString()}')
            : Text('error')),
      ),
    );
  }
}
