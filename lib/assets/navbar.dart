import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_control/assets/aircon.dart';
import 'package:smart_control/assets/homepage.dart';
import 'package:smart_control/assets/light.dart';
import 'package:smart_control/assets/settings.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
    extendBody: true,
    backgroundColor: Colors.white,
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
	    
          ),
          child: NavigationBar(
	    backgroundColor: Colors.white,
            height: 80,
            elevation: 3,
	    shadowColor: Colors.black12,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
                NavigationDestination(icon: Icon(Icons.home), label: 'Home'),  // dashboard
                NavigationDestination(icon: Icon(Icons.ac_unit), label: 'AirCon'),
                NavigationDestination(icon: Icon(Icons.light_mode), label: 'Light'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;  //default open page 

  final screens = [
    HomePage(),
    aircon(),
    light(),
    SettingsPage(),
  ];
}

