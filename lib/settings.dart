import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSwitched = false;
  bool darkmode = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
          children: const [Icon(Icons.settings), Text('   Settings')],
        )),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    onTap: () => {setState(() {})},
                    title: darkmode
                        ? const Text("Dark Mode")
                        : const Text("Light Mode"),
                    leading: darkmode
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                    trailing: Switch(
                      value: darkmode,
                      onChanged: (value) {
                        setState(() {
                          if (Get.isDarkMode) {
                            Get.changeTheme(ThemeData.light());
                            darkmode = false;
                          } else {
                            Get.changeTheme(ThemeData.dark());
                            darkmode = true;
                          }
                        });
                      },
                      activeTrackColor: Colors.blue,
                      activeColor: Colors.blue,
                    ),
                  )),
            ]));
  }
}
