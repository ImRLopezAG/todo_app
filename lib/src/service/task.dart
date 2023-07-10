import 'package:todo_app/src/src.dart';

abstract class GenericRepository<T> {
  Future<List<T>> getAll();
  Future<T> getById(int id);
  Future<T> create(T entity);
  Future<T> update(T entity);
  Future delete(int id);
}

class TaskRepository implements GenericRepository<Task> {
  final SQLHelper _sqlHelper = SQLHelper();

  @override
  Future<List<Task>> getAll() async {
    final db = await _sqlHelper.db;
    final maps = await db.query('tasks');
    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

  @override
  Future<Task> getById(int id) async {
    final db = await _sqlHelper.db;
    final maps = await db.query('tasks', where: 'id = ?', whereArgs: [id]);
    return Task.fromMap(maps.first);
  }

  @override
  Future<Task> create(Task entity) async {
    final db = await _sqlHelper.db;
    final id = await db.insert('tasks', entity.toMap());
    return entity.copyWith(id: id);
  }

  @override
  Future<Task> update(Task entity) async {
    final db = await _sqlHelper.db;
    await db.update('tasks', entity.toMap(),
        where: 'id = ?', whereArgs: [entity.id]);
    return entity;
  }

  @override
  Future delete(int id) async {
    final db = await _sqlHelper.db;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future setDone(int id) async {
    final db = await _sqlHelper.db;
    final isDone = await getById(id).then((task) => task.isDone == 1 ? 0 : 1);
    await db.update('tasks', {'isDone': isDone},
        where: 'id = ?', whereArgs: [id]);
  }
}
