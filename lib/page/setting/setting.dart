import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/theme_provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Toggle Dark Mode"),
            Consumer<ThemeProvider>(
              builder: (context, value, child) => Switch(
                value: value.themeMode == ThemeMode.dark,
                onChanged: (_) {
                  if (value.themeMode == ThemeMode.dark) {
                    value.setThemeMode(ThemeMode.light);
                  } else {
                    value.setThemeMode(ThemeMode.dark);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
