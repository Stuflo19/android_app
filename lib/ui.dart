import 'package:flutter/material.dart';
import 'settings.dart';
import 'todo.dart';

class UI {
  Widget sidebar(context) {
    return Drawer(
        child: ListView(children: [
      const DrawerHeader(
        child: Text("Android-App"),
      ),
      Card(
          child: ListTile(
        title: Text("To-Do Page"),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const TodoPage()));
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
