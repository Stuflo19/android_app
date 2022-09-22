import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui.dart';
import 'database.dart';
import 'tile.dart';
import 'task.dart';

// ignore: must_be_immutable
class DetailsPage extends StatefulWidget {
  var index;

  DetailsPage({Key? key, required this.index}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isSwitched = false;
  bool darkmode = Get.isDarkMode;
  UI ui = UI();
  DBManager db = DBManager();
  var index;
  var tile;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String titleText = "";
  String contentText = "";
  List selectedItems = [];
  var tasks;

  Future<Tile> setup() async {
    index = widget.index;
    tile = await db.readTile(index);
    tasks = await db.readTasks(index);
    _titleController = TextEditingController(text: tile.name);
    _contentController = TextEditingController(text: tile.content);
    return tile;
  }

  void boxClicked(bool selected, checked) {
    if (selected == true) {
      setState(() {
        checked = 1;
      });
    } else {
      setState(() {
        checked = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              children: const [Icon(Icons.home), Text('   Task Title')],
            )),
        body: FutureBuilder(
            future: setup(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: [
                  TextField(
                      textAlign: TextAlign.center,
                      onSubmitted: (newValue) {
                        setState(() {
                          titleText = newValue;
                        });
                      },
                      controller: _titleController),
                  TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onSubmitted: (newValue) {
                        setState(() {
                          contentText = newValue;
                        });
                      },
                      controller: _contentController),
                  if (tasks != null)
                    SizedBox(
                        width: 600,
                        height: 400,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: tasks.length,
                            itemBuilder: (context, int i) {
                              return CheckboxListTile(
                                value: tasks[i].complete == 1 ? true : false,
                                onChanged: (selected) {
                                  setState(() {
                                    print(selected);
                                    print(tasks[i].complete);
                                    selected!
                                        ? tasks[i].setComplete(1)
                                        : tasks[i].setComplete(0);
                                    print(tasks[i].complete);
                                    db.updateTask(tasks[i]);
                                  });
                                },
                                title: Text(tasks[i].task),
                              );
                            }))
                ]);
              }

              return Center(child: CircularProgressIndicator());
            }));
  }
}
