import 'package:flutter/material.dart';
import 'settings.dart';
import 'homepage.dart';

class UI {
  Widget sidebar(context) {
    return Drawer(
        child: ListView(children: [
      const DrawerHeader(
        child: Text("Android-App"),
      ),
      Card(
          child: ListTile(
        title: Text("Homepage"),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const HomePage()));
        },
      )),
      Card(
          child: ListTile(
        title: Text("Settings"),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsPage()));
        },
      ))
    ]));
  }
}
