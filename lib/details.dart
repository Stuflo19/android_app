import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ui.dart';
import 'database.dart';
import 'tile.dart';

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
  bool _isEditingText = false;
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  String titleText = "";
  String contentText = "";

  Future<Tile> setup() async {
    index = widget.index;
    tile = await db.readTile(index);
    _titleController = TextEditingController(text: tile.name);
    _contentController = TextEditingController(text: tile.content);
    return tile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ui.sidebar(context),
      appBar: AppBar(
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
                      _isEditingText = false;
                    });
                  },
                  controller: _titleController),
              TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  onSubmitted: (newValue) {
                    setState(() {
                      contentText = newValue;
                      _isEditingText = false;
                    });
                  },
                  controller: _contentController)
            ]);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
