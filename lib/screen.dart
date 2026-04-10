import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> tasks = [];

  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].isDone = !tasks[index].isDone;
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

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
          decoration: const InputDecoration(hintText: "Enter task"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("StudyTrack"), centerTitle: true),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: tasks[index],
            onToggle: () => toggleTask(index),
            onDelete: () => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
