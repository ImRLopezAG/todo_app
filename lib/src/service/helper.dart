import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static final SQLHelper _instance = SQLHelper._internal();

  factory SQLHelper() => _instance;

  SQLHelper._internal();

  static sql.Database? _database;

  Future<sql.Database> get db async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDb();
    return _database!;
  }

  Future<sql.Database> initDb() async {
    final databasePath = await sql.getDatabasesPath();
    final path = '$databasePath/todo.db';
    final database = await sql.openDatabase(
      path,
      version: 1,
      onCreate: (db, newerVersion) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS tasks('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title TEXT, '
          'description TEXT, '
          'isDone INTEGER)',
        );
      },
    );
    return database;
  }
}
