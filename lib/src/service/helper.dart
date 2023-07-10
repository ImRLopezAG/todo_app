import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static final SQLHelper _instance = SQLHelper.internal();
  factory SQLHelper() => _instance;
  SQLHelper.internal();
  
  Future<sql.Database> get db async => _instance.initDb();

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
          'isDone INTEGER)'
        );
      },
    );
    return database;
  }

}
