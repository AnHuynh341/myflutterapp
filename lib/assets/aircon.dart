import 'package:flutter/material.dart';
import 'package:smart_control/assets/aircontab1.dart';
import 'package:smart_control/assets/aircontab2.dart';


class aircon extends StatefulWidget {
  const aircon({Key? key}) : super(key: key);

  @override
  _airconPage createState() => _airconPage();
}

class _airconPage extends State<aircon>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      title: const Text('Air Conditioner'),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: TabBar(
                controller: tabController,
                unselectedLabelColor: Colors.white,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                tabs: const [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                AirconTab1(),
                airconTab2(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
 }
} 
