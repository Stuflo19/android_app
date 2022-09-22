import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'todo.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Android app',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoPage(),
    );
  }
}
