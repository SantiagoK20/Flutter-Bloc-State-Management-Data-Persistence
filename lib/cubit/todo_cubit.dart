import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';
import '../services/storage.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]) {
    load();
  }

  void load() => emit(Storage.getAll());

  void add(String title) async {
    if (title.trim().isEmpty) return;
    await Storage.add(title);
    load();
  }

  void toggle(String id) async {
    await Storage.toggle(id);
    load();
  }

  void delete(String id) async {
    await Storage.delete(id);
    load();
  }
}
