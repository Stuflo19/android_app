import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui.dart';
import 'database.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  bool isSwitched = false;
  bool darkmode = Get.isDarkMode;
  UI ui = UI();
  DBManager db = DBManager();
  List tiles = [];

  Future<List> setup() async {
    tiles = await db.readTiles();
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ui.sidebar(context),
      appBar: AppBar(
          title: Row(
        children: const [Icon(Icons.home), Text('   To-Do Page')],
      )),
      body: FutureBuilder(
        future: setup(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
                padding: EdgeInsets.all(15),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                scrollDirection: Axis.vertical,
                itemCount: tiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(tiles[index].name),
                    subtitle: Text(tiles[index].content),
                    onTap: () {
                      //open full view of the item
                    },
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blueGrey[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
