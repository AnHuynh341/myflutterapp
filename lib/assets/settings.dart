import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  String networkName = 'SmartHome_WiFi_5G';

  void _toggleDarkMode(bool value) {
    setState(() {
      isDarkMode = value;
      print('[SETTINGS] Dark Mode: $isDarkMode');
    });
  }

  void _toggleNotifications(bool value) {
    setState(() {
      notificationsEnabled = value;
      print('[SETTINGS] Notifications: $notificationsEnabled');
    });
  }

  void _refreshDevices() {
    print('[SETTINGS] Refreshing devices...');
    // mock delay or action
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Devices refreshed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: _toggleDarkMode,
            secondary: const Icon(Icons.dark_mode),
          ),
          SwitchListTile(
            title: const Text('Enable Notifications'),
            value: notificationsEnabled,
            onChanged: _toggleNotifications,
            secondary: const Icon(Icons.notifications_active),
          ),
          ListTile(
            leading: const Icon(Icons.wifi),
            title: const Text('Wi-Fi Network'),
            subtitle: Text(networkName),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              print('[SETTINGS] Tapped Wi-Fi row');
            },
          ),
          ListTile(
            leading: const Icon(Icons.sync),
            title: const Text('Refresh Devices'),
            onTap: _refreshDevices,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Smart Home Control App v1.0 by AnHuynh'),
          ),
        ],
      ),
    );
  }
}

