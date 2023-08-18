import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkThemeEnabled = true;
  bool _notificationEnabled = true;
  bool _autoRefreshEnabled = false;
  int _selectedRefreshInterval = 30;

  final List<int> _refreshIntervals = [10, 30, 60, 120, 300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black45,
        title: Text('Settings'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text('DarkTheme'.tr()),
              value: _darkThemeEnabled,
              onChanged: (value) {
                setState(() {
                  _darkThemeEnabled = value;
                });
                _applyTheme();
              },
            ),
            SwitchListTile(
              title: Text('Notification'.tr()),
              value: _notificationEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationEnabled = value;
                });
                _applyNotificationSettings();
              },
            ),
            SwitchListTile(
              title: Text('Automatic Refresh'.tr()),
              value: _autoRefreshEnabled,
              onChanged: (value) {
                setState(() {
                  _autoRefreshEnabled = value;
                });
                _applyAutoRefreshSettings();
              },
            ),
            ListTile(
              title: Text('Refresh Interval'.tr()),
              trailing: DropdownButton<int>(
                value: _selectedRefreshInterval,
                onChanged: (selectedInterval) {
                  setState(() {
                    _selectedRefreshInterval = selectedInterval!;
                  });
                  _applyRefreshIntervalSettings();
                },
                items: _refreshIntervals.map((interval) {
                  return DropdownMenuItem<int>(
                    value: interval,
                    child: Text('$interval saniye'),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyTheme() {
    if (_darkThemeEnabled) {
      _saveThemePreference(true);
      MyApp.applyDarkTheme();
    } else {
      _saveThemePreference(false);
      MyApp.applyLightTheme();
    }
  }

  void _saveThemePreference(bool isDarkTheme) {
  }


  void _applyNotificationSettings() {

  }

  void _applyAutoRefreshSettings() {

  }

  void _applyRefreshIntervalSettings() {

  }
}