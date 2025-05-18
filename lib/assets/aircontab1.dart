import 'package:flutter/material.dart';


class airconTab1 extends StatelessWidget {
  const airconTab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: Column( 
       children: [ 
	airconMode()
        ],
       )
    );
  }
}

class airconMode extends StatefulWidget {
  @override
  _airconMode createState() => _airconMode();
}

class _airconMode extends State<airconMode> {
  int _selectedIndex = 0;
  final List<String> _options = ['One', 'Two', 'Three', 'Four'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      	ToggleButtons(
            borderColor: Colors.deepPurple,
            selectedBorderColor: Colors.cyan,
            borderWidth: 1,
            selectedColor: Colors.white,
            color: Colors.cyan,
            fillColor: Colors.cyan.shade100,
            borderRadius: BorderRadius.circular(20),
            children: _options.map((String label) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(label),
            )).toList(),
            onPressed: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            isSelected: List.generate(_options.length, (index) => index == _selectedIndex),
          )
        ],
      ),
    );
  }
}
