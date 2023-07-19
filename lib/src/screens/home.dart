import 'package:flutter/material.dart';
import 'package:todo_app/src/src.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, TextEditingController> _controllers = {
    'title': TextEditingController(),
    'description': TextEditingController(),
  };
  final List<Task> _tasks = [];
  final _repository = TaskRepository();

  @override
  void initState() {
    super.initState();
    _getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo App',
              style: TextStyle(
                fontSize: 30,
              )),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: ListView.separated(
                itemCount: _tasks.length,
                separatorBuilder: (context, i) => const SizedBox(height: 10),
                itemBuilder: (context, i) {
                  final task = _tasks[i];
                  return CardTask(
                    title: task.title,
                    description: task.description,
                    isDone: task.isDone == 1,
                    onDone: () async => await _handleDone(id: task.id!),
                    onDelete: () => _deleteTask(id: task.id!),
                    onEdit: () async => await _showModal(index: i),
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => await _showModal(),
          child: const Icon(Icons.note_add_rounded),
        ));
  }

  Future _showModal({int? index}) async {
    int? id;
    if (index != null) {
      final task = _tasks[index];
      _controllers['title']!.text = task.title;
      _controllers['description']!.text = task.description;
      id = task.id;
    }
    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context) {
        return Modal(
          id: id,
          controllers: _controllers,
          saveTask: _saveTask,
        );
      },
    ).then((_) {
      _controllers['title']!.clear();
      _controllers['description']!.clear();
    });
  }

  Future _saveTask({int? id}) async {
    final task = Task(
      title: _controllers['title']!.text,
      description: _controllers['description']!.text,
    );
    if (id != null) {
      await _repository.update(task.copyWith(id: id));
    } else {
      await _repository.create(task);
    }
    _showSnackBar(text: 'Task saved successfully!');
    setState(() {
      _getTasks();
      _controllers['title']!.clear();
      _controllers['description']!.clear();
    });
  }

  void _showSnackBar({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(text),
          duration: const Duration(seconds: 1),
          animation: CurvedAnimation(
            parent: const AlwaysStoppedAnimation(1),
            curve: Curves.easeInOut,
          )),
    );
  }

  void _deleteTask({required int id}) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await _repository.delete(id);
              _showSnackBar(text: 'Task deleted successfully!');
              setState(() {
                _getTasks();
              });
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _getTasks() async {
    final tasks = await _repository.getAll();
    setState(() {
      _tasks.clear();
      _tasks.addAll(tasks);
    });
  }

  Future _handleDone({required int id}) async {
    await _repository.setDone(id);
    setState(() {
      _getTasks();
    });
  }
}
