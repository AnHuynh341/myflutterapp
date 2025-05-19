import 'package:flutter/material.dart';
import 'package:smart_control/assets/devices.dart';


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
	    AirconSwitch(),
	    SizedBox(height: 10),
            AirconMode(),
          ],
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////////////////////////////


class AirconSwitch extends StatefulWidget {
  const AirconSwitch({super.key});

  @override
  State<AirconSwitch> createState() => _AirconSwitchState();
}

class _AirconSwitchState extends State<AirconSwitch> {
  final Device device = DeviceManager().devices[0]; // Only 1 aircon in this tab

  void _toggleDevice() {
    setState(() {
      device.isOn = !device.isOn;
      print('${device.name} toggled: ${device.isOn ? 'ON' : 'OFF'}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Expanded(
              child: Card(
                shape: RoundedRectangleBorder( 
                    borderRadius: BorderRadius.circular(90),
		     side: BorderSide( 
		     color: device.isOn ? Colors.purple : Colors.grey,
		     width: 1,
		     ),
		),
                color: Colors.lightBlue.shade100,
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child:
                      Text(
                        device.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),

            Expanded(
              child: InkWell(
                onTap: _toggleDevice,
                borderRadius: BorderRadius.circular(90),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
		      side: BorderSide( 
		        color: device.isOn ? Colors.purple : Colors.grey,
			width: 1,
		       ),
		  ),
                  color: device.isOn
                      ? Colors.lightBlue.shade100
                      : Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child:  Icon(
                            device.icon,
                            size: 42,
                            color: device.isOn ? Colors.blue : Colors.grey,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




//////////////////////////////////////////////////////////////////////////////


class AirconMode extends StatefulWidget {
  const AirconMode({Key? key}) : super(key: key); 

  @override
  _AirconModeState createState() => _AirconModeState();
}

class _AirconModeState extends State<AirconMode> {
  int _selectedIndex = 0;
  final List<IconData> _options = [
    Icons.ac_unit, 
    Icons.water_drop,
    Icons.air,
    Icons.energy_savings_leaf,
    ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
           ToggleButtons(
              borderColor: Colors.deepPurple,
              selectedBorderColor: Colors.cyan,
              borderWidth: 1,
              selectedColor: Colors.white,
              color: Colors.cyan,
              fillColor: Colors.cyan.shade100,
              borderRadius: BorderRadius.circular(90),
              children: _options
                  .map((IconData) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                          child: Icon(IconData),
                        ),
                  )
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

