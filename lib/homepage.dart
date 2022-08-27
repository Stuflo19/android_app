import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSwitched = false;
  bool darkmode = Get.isDarkMode;
  UI ui = UI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ui.sidebar(context),
        appBar: AppBar(
            title: Row(
          children: const [Icon(Icons.home), Text('   Homepage')],
        )),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Available topics",
                          style: TextStyle(fontSize: 24)))),
              Card(
                  margin: const EdgeInsets.all(15),
                  child: ListTile(
                    title: Text("Topic 1"),
                    subtitle: Text("Information about topic"),
                    onTap: () {},
                  )),
            ]));
  }
}
