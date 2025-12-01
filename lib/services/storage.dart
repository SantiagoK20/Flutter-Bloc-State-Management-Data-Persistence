import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo.dart';

class Storage {
  static const String boxName = 'todos';
  static late Box<Todo> box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TodoAdapter());
    box = await Hive.openBox<Todo>(boxName);
  }

  static List<Todo> getAll() => box.values.toList();

  static Future<void> add(String title) async {
    final todo = Todo(id: DateTime.now().toString(), title: title);
    await box.put(todo.id, todo);
  }

  static Future<void> toggle(String id) async {
    final todo = box.get(id);
    if (todo != null) {
      todo.isDone = !todo.isDone;
      await todo.save();
    }
  }

  static Future<void> delete(String id) async {
    await box.delete(id);
  }
}
