import 'package:flutter/material.dart';

class AirconTab1 extends StatelessWidget {
  const AirconTab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AirconMode(),
          ],
        ),
      ),
    );
  }
}

class AirconMode extends StatefulWidget {
  const AirconMode({Key? key}) : super(key: key); 

  @override
  _AirconModeState createState() => _AirconModeState();
}

class _AirconModeState extends State<AirconMode> {
  int _selectedIndex = 0;
  final List<String> _options = ['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ToggleButtons(
            borderColor: Colors.deepPurple,
            selectedBorderColor: Colors.cyan,
            borderWidth: 1,
            selectedColor: Colors.white,
            color: Colors.cyan,
            fillColor: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(20),
            children: _options
                .map((label) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(label),
                    ))
                .toList(),
            onPressed: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            isSelected: List.generate(
              _options.length,
              (index) => index == _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }
}

