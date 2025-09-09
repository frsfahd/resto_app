import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/setting_provider.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Future<void> _checkPendingNotificationRequests(
    SettingProvider settingProvider,
  ) async {
    await settingProvider.checkPendingNotificationRequests(context);

    if (!mounted) {
      return;
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final pendingData = context.select(
          (SettingProvider provider) => provider.pendingNotificationRequests,
        );
        return AlertDialog(
          title: Text(
            '${pendingData.length} pending notification requests',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: ListView.builder(
              itemCount: pendingData.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = pendingData[index];
                return ListTile(
                  title: Text(
                    item.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    item.body ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  contentPadding: EdgeInsets.zero,
                  trailing: IconButton(
                    onPressed: () {
                      settingProvider
                        ..cancelNotification(item.id)
                        ..checkPendingNotificationRequests(context);
                    },
                    icon: const Icon(Icons.delete_outline),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

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
            SwitchListTile(
              title: Text("Lunch Remainder (11.00 AM)"),
              value: settingProvider.setting!.isLunchNotif,
              onChanged: (_) async {
                await settingProvider.toggleNotification();
              },
            ),
            FilledButton(
              onPressed: () {
                _checkPendingNotificationRequests(settingProvider);
              },
              child: Text("Check notification"),
            ),
          ],
        ),
      ),
    );
  }
}
