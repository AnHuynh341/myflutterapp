// lib/models/device.dart
import 'package:flutter/material.dart';

class Device {
  final String id;
  final String name;
  final IconData icon;
  bool isOn;
  double temperature;
  double luminosity;
  int modeIndex;   

  Device({
    required this.id,
    required this.name,
    required this.icon,
    required this.isOn,
    this.temperature = 22.0, // Default temperature
    this.modeIndex = 0,
    this.luminosity = 50,
  });
}

class DeviceManager {
  static final DeviceManager _instance = DeviceManager._internal();

  factory DeviceManager() {
    return _instance;
  }

  DeviceManager._internal();

  final List<Device> devices = [
    Device(id: 'ac1', name: 'AirCon 1', icon: Icons.ac_unit, isOn: true, temperature: 22.0, modeIndex: 0),
    Device(id: 'ac2', name: 'AirCon 2', icon: Icons.ac_unit, isOn: false, temperature: 22.0, modeIndex: 0),    
    Device(id: 'light1', name: 'Light 1', icon: Icons.lightbulb, isOn: false, luminosity: 50),
    Device(id: 'light2', name: 'Light 2', icon: Icons.lightbulb, isOn: true, luminosity: 50),
  ];

  Device getDeviceById(String id) =>
      devices.firstWhere((device) => device.id == id);
}

