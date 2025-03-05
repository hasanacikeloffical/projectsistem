import 'package:flutter/material.dart';
import 'package:projectsistem/loginPage.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationsEnabled = true;
  double _volume = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ayarlar')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Bildirimleri Aç"),
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Ses Seviyesi", style: TextStyle(fontSize: 18)),
            Slider(
              value: _volume,
              min: 0,
              max: 100,
              divisions: 10,
              label: _volume.round().toString(),
              onChanged: (value) {
                setState(() {
                  _volume = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
