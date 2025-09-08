import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/setting_provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final settingProvider = context.watch<SettingProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              title: Text("Dark Mode"),
              value: settingProvider.setting!.isDarkMode,
              onChanged: (_) => settingProvider.toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
