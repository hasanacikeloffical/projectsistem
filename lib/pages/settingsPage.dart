import 'package:flutter/material.dart';
import 'package:projectsistem/core/ThemeManager.dart';
import 'package:projectsistem/core/localemanager.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: Colors.purple.shade100,
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: Text('Ayarlar'),
      ),
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
            SizedBox(height: 20),
            SettingsWidget(), // Yeni bileşeni ekledik
          ],
        ),
      ),
    );
  }
}

// **Ayrı bir ayar bileşeni olarak SettingsWidget**
class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final localManager = Provider.of<LocalManager>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localManager.translate('dark_theme')),
            Switch(
              value: themeManager.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeManager.toggleTheme();
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(localManager.translate('language')),
            const SizedBox(width: 10),
            DropdownButton<Locale>(
              value: localManager.currentLocale,
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  localManager.changedLocale(newLocale);
                }
              },
              items: const [
                DropdownMenuItem(value: Locale('en'), child: Text('English')),
                DropdownMenuItem(value: Locale('tr'), child: Text('Türkçe')),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
