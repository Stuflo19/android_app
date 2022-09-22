import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'tile.dart';
import 'task.dart';

//Class for managing the database
class DBManager {
  var database; //variable for holding the path to the database
  DBManager() {
    this.database = openDB(); //inisitalises the link to the database
  }

  //Function for opening the database
  Future<Database> openDB() async {
    const String dbName = 'task_database'; //holds the name of the database
    final String dbPath =
        join(await getDatabasesPath(), dbName); //holds the path to the database

    // Variable used to hold the open database
    final Future<Database> database = openDatabase(
      join(dbPath, dbName),
      version:
          1, // Set the version to perform database upgrades and downgrades.

      //creates database if it doesn't exist
      onCreate: (db, version) {
        //returns a new table called title with id, name and content columns
        return db.execute(
          "CREATE TABLE tile(id INTEGER PRIMARY KEY, name TEXT, content TEXT)",
        );
        //"CREATE TABLE task(taskNo INTEGER PRIMARY KEY, id INTEGER, task TEXT, complete INTEGER)"
      },
    );
    return database;
  }

  //function for adding a new tile to the database
  Future<void> addTileToDB(Tile tile) async {
    final Database db = await database;

    //inserts the tile into the tile table, if ID already exists replace it
    await db.insert(
      'tile',
      tile.tileToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    final Database db = await database;

    await db.update(
      'task',
      task.taskToMap(),
      where: 'taskNo= ?',
      whereArgs: [task.taskNo],
    );
  }

  Future<List<Task>> readTasks(int id) async {
    final Database db = await database;

    // Gets all the tiles from the tile table
    final List<Map<String, dynamic>> tasks =
        await db.query('task', where: 'id=$id');

    return List.generate(tasks.length, (i) {
      return Task(
        taskNo: tasks[i]['taskNo'],
        id: tasks[i]['id'],
        task: tasks[i]['task'],
        complete: tasks[i]['complete'],
      );
    });
  }

  //function for adding a new tile to the database
  Future<void> addTaskToDB(Task task) async {
    final Database db = await database;

    //inserts the tile into the tile table, if ID already exists replace it
    await db.insert(
      'task',
      task.taskToMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Function to read in all tiles from the database
  Future<Tile> readTile(int id) async {
    final Database db = await database;

    // Gets all the tiles from the tile table
    final List<Map<String, dynamic>> tiles =
        await db.query('tile', where: 'id=$id');
    return Tile(
      id: tiles[0]['id'],
      name: tiles[0]['name'],
      content: tiles[0]['content'],
    );
  }

  // Function to read in all tiles from the database
  Future<List<Tile>> readTiles() async {
    final Database db = await database;

    // Gets all the tiles from the tile table
    final List<Map<String, dynamic>> tiles = await db.query('tile');

    return List.generate(tiles.length, (i) {
      return Tile(
        id: tiles[i]['id'],
        name: tiles[i]['name'],
        content: tiles[i]['content'],
      );
    });
  }
}
