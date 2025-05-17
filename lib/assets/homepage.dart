import 'package:flutter/material.dart';
import 'package:smart_control/assets/devices.dart'; // import Device and DeviceManager

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Device> devices = DeviceManager().devices;

  void _toggleDevice(Device device) {
    setState(() {
      device.isOn = !device.isOn;
        print('${device.name} toggled: ${device.isOn ? 'ON' : 'OFF'}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: const Text('Dashboard'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: devices.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final device = devices[index];
              return InkWell(
                onTap: () => _toggleDevice(device),
                borderRadius: BorderRadius.circular(16),
                child: Card(
                  color: device.isOn
                      ? Colors.lightBlue.shade100
                      : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(device.icon,
                            size: 48,
                            color: device.isOn ? Colors.blue : Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          device.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          device.isOn ? 'Status: ON' : 'Status: OFF',
                          style: TextStyle(
                              color: device.isOn ? Colors.green : Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      
    );
  }
}

