import 'package:flutter/material.dart';
import 'package:smart_control/assets/devices.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_control/assets/utils.dart';

class LightTab2 extends StatelessWidget {
  const LightTab2({Key? key}) : super(key: key);

    final String deviceId = 'light2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 10),
              const Center(
                 child: Text('Set Brightness',
                   style: TextStyle(
                     fontSize: 24, 
                     fontWeight: FontWeight.bold,
                     letterSpacing: 1.2,
                     color: Colors.black87, 
                   ),
                 ),
              ),              
              const SizedBox(height: 10),
              SliderWidget(deviceId: deviceId),
              const SizedBox(height: 5),
              AirconSwitch(deviceId: deviceId),
              const SizedBox(height: 10),
          ],        
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////////////////////////////


class AirconSwitch extends StatefulWidget {
   final String deviceId;
  const AirconSwitch({Key? key, required this.deviceId}) : super(key: key);

  @override
  State<AirconSwitch> createState() => _AirconSwitchState();
}

class _AirconSwitchState extends State<AirconSwitch> {
  late Device device;

  
  @override
  void initState() {
    super.initState();
    device = DeviceManager().getDeviceById(widget.deviceId);
  }

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
                    color: device.isOn ? Colors.purple : Colors.grey, width: 1,
                  ),
                ),
                color: Colors.lime.shade100,
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
                      side: BorderSide(color: device.isOn ? Colors.red : Colors.grey, width: 1),
                  ),
                  color: device.isOn
                      ? Colors.lime.shade100
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



///////////////////////////////////////////////////////////////////////////

class SliderWidget extends StatefulWidget {
   final String deviceId;
  const SliderWidget({Key? key, required this.deviceId}) : super(key: key);


  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  late double progressVal;
   late Device device;

  @override
  void initState() {
    super.initState();
    device = DeviceManager().getDeviceById(widget.deviceId);
    progressVal = normalize(device.luminosity, kMinLuminosity, kMaxLuminosity).toDouble();
  }

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
                colors: [Colors.yellow[200]!, Colors.grey.withAlpha(50)],
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
                    padding: const EdgeInsets.all(70.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.yellow,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40,
                            spreadRadius: 45,
                            color: Colors.yellow.withAlpha(
                              normalize(progressVal * 20000, 100, 255).toInt(),
                            ),
                            offset: Offset(1, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: SleekCircularSlider(
                      min: kMinLuminosity,
                      max: kMaxLuminosity,
                      initialValue: device.luminosity,
                      appearance: CircularSliderAppearance(
                        startAngle: 150,
                        angleRange: 240,
                        size: kDiameter - 55,
                        customWidths: CustomSliderWidths(
                          trackWidth: 5.0,
                          shadowWidth: 1,
                          progressBarWidth: 10,
                          handlerSize: 12,
                        ),
                        customColors: CustomSliderColors(
                          hideShadow: true,
                          progressBarColor: Colors.yellow,
                          trackColor: Colors.grey.shade300,
                          dotColor: Colors.orange,
                        ),
                      ),
                      onChange: (value) {
                        setState(() {
                          device.luminosity = value;
                          progressVal = normalize(value, kMinLuminosity, kMaxLuminosity).toDouble();
                        });
                      },
                      innerWidget: (percentage) {
                        return Center(
                          child: Text(
                            '${percentage?.toInt()}%',
                            style: TextStyle(
                              fontSize: 35,
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
