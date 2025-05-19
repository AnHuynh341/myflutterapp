import 'package:flutter/material.dart';
import 'package:smart_control/assets/devices.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_control/assets/utils.dart';

class AirconTab1 extends StatelessWidget {
  const AirconTab1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
	    SizedBox(height: 20),
	    Center(child: Text('Temperature') ),
	    SizedBox(height: 20),
	    SliderWidget(),
	    SizedBox(height: 10),
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


///////////////////////////////////////////////////////////////////////////

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  double progressVal = 0.5;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ShaderMask(
            shaderCallback: (rect) {
              return SweepGradient(
                startAngle: degToRad(0).toDouble(),
                endAngle: degToRad(180).toDouble(),
                colors: [Colors.blue[200]!, Colors.grey.withAlpha(50)],
                stops: [progressVal, progressVal],
                transform: GradientRotation(
                  degToRad(180).toDouble(),
                ),
              ).createShader(rect);
            },
          ),
          Center(
            child: Container(
              width: kDiameter,
              height: kDiameter,
	      decoration: BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
		  Padding(
                   padding: const EdgeInsets.all(65.0),
                   child: Container(  
                   decoration: BoxDecoration( 
                     color: Colors.white,
                     shape: BoxShape.circle,
                     border: Border.all(
                       color: Colors.lightBlue,width: 2,
                       style: BorderStyle.solid,
                     ),
                     boxShadow: [  
                        BoxShadow(
                            blurRadius: 30,
                            spreadRadius: 10,
                            color: Colors.blue.withAlpha(
                                normalize(progressVal * 20000, 100, 255).toInt()),
                            offset: Offset(1, 3),
                		      ),
                		    ],
                		 ),
                	),
			),
                   Center(
                     child: SleekCircularSlider(
                                       min: kMinDegree,
                                       max: kMaxDegree,
                                       initialValue: 22,
                                       appearance: CircularSliderAppearance(
                      startAngle: 180,
                      angleRange: 180,
                      size: kDiameter -50,
                      customWidths: CustomSliderWidths(
                        trackWidth: 10,
                        shadowWidth: 1,
                        progressBarWidth: 03,
                        handlerSize: 12,
                      ),
                      customColors: CustomSliderColors(
                        hideShadow: true,
                        progressBarColor: Colors.blue,
                        trackColor: Colors.transparent,
                        dotColor: Colors.blue,
                      ),
                                       ),
                                       onChange: (value) {
                      setState(() {
                        progressVal = normalize(value, kMinDegree, kMaxDegree).toDouble();
                      });
                                       },
                                       innerWidget: (percentage) {
                      return Center(
                        child: Text(
                          '${percentage?.toInt()}°c',
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      );
                                       },
                                     ),
                   ),
		],
                            ),
                          ),
              ),

        ],
      ),
    );
  }
}
