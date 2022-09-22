//Class used to hold the contents of the tiles on the homepage
class Task {
  final int taskNo; //unique identifier
  final int id; //matches ID to tile
  String task; //name/title of the tile
  int complete; //holds 0 for uncomplete or 1 for complete

  Task(
      {required this.taskNo,
      required this.id,
      required this.task,
      required this.complete});

  //turns the tile into a map
  Map<String, dynamic> taskToMap() {
    return {
      'taskNo': taskNo,
      'id': id,
      'task': task,
      'complete': complete,
    };
  }

  setComplete(int newValue) {
    complete = newValue;
  }

  setTask(String newValue) {
    task = newValue;
  }
}
