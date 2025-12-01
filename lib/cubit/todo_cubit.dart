import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  final List<Todo> _todos = [];

  void _refresh() => emit(List.from(_todos));

  void add(String title) {
    if (title.trim().isEmpty) return;

    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
    );
    _todos.add(todo);
    _refresh();
  }

  void toggle(String id) {
    final todo = _todos.firstWhere((t) => t.id == id,
        orElse: () => Todo(id: '', title: ''));
    if (todo.id.isNotEmpty) {
      todo.isDone = !todo.isDone;
      _refresh();
    }
  }

  void delete(String id) {
    _todos.removeWhere((t) => t.id == id);
    _refresh();
  }
}
