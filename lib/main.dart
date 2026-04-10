import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskScreen(),
    );
  }
}

// ✅ Task Model
class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

// ✅ Main Screen
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  // ➕ Add Task
  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  // ✅ Toggle Task
  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  // 🗑 Delete Task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // 📝 Dialog Box
  void showAddTaskDialog() {
    String newTask = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Task"),
        content: TextField(
          onChanged: (value) {
            newTask = value;
          },
          decoration: const InputDecoration(hintText: "Enter your task"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (newTask.isNotEmpty) {
                addTask(newTask);
              }
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // 🎨 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StudyTrack"), centerTitle: true),

      // 📋 Task List
      body: tasks.isEmpty
          ? const Center(child: Text("No tasks yet"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    title: Text(
                      tasks[index].title,
                      style: TextStyle(
                        decoration: tasks[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    leading: Checkbox(
                      value: tasks[index].isDone,
                      onChanged: (value) {
                        toggleTask(index);
                      },
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        deleteTask(index);
                      },
                    ),
                  ),
                );
              },
            ),

      // ➕ FAB
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
