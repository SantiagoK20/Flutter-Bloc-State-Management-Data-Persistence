// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<TodoCubit, List<dynamic>>(
        builder: (context, todos) {
          if (todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_add_outlined,
                      size: 90, color: Colors.grey[600]),
                  const SizedBox(height: 24),
                  Text("No tasks yet",
                      style: TextStyle(fontSize: 20, color: Colors.grey[400])),
                  const SizedBox(height: 8),
                  Text("Tap + to add one",
                      style: TextStyle(color: Colors.grey[500])),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Dismissible(
                key: Key(todo.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:
                      const Icon(Icons.delete, color: Colors.white, size: 28),
                ),
                onDismissed: (_) => context.read<TodoCubit>().delete(todo.id),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 5,
                  color: const Color(0xFF1A1A1A),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    leading: GestureDetector(
                      onTap: () => context.read<TodoCubit>().toggle(todo.id),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: todo.isDone
                              ? Colors.deepPurpleAccent
                              : Colors.transparent,
                          border: Border.all(
                              color: Colors.deepPurpleAccent, width: 2.5),
                        ),
                        child: todo.isDone
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 20)
                            : null,
                      ),
                    ),
                    title: Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: todo.isDone ? Colors.grey[500] : Colors.white,
                        decoration:
                            todo.isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    // Added "Swipe to delete" hint
                    trailing: const Text(
                      "Swipe to delete",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 50,
                        height: 6,
                        decoration: BoxDecoration(
                            color: Colors.grey[600],
                            borderRadius: BorderRadius.circular(3))),
                    const SizedBox(height: 24),
                    const Text('New Task',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'What needs to be done?',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: const Color(0xFF1E1E1E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {
                          final text = controller.text.trim();
                          if (text.isNotEmpty) {
                            context.read<TodoCubit>().add(text);
                            controller.clear();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add Task',
                            style:
                                TextStyle(color: Colors.white, fontSize: 17)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
