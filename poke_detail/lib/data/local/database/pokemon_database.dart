import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class PokemonDatabase {
  static final PokemonDatabase instance = PokemonDatabase._init();
  static Database? _database;

  PokemonDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('poke_fl.db"');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, fileName);
    return await openDatabase(
      path,
    );
  }

  Future<dynamic> getPokemonById(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'pokemon',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
