//Class used to hold the contents of the tiles on the homepage
class Tile {
  final int id; //unique identifier
  final String name; //name/title of the tile
  final String content; //brief description of the tile
  var list;

  Tile(
      {required this.id, required this.name, required this.content, this.list});

  //turns the tile into a map
  Map<String, dynamic> tileToMap() {
    return {
      'id': id,
      'name': name,
      'content': content,
      if (list != null) 'list': list,
    };
  }
}
