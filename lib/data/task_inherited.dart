import 'package:flutter/material.dart';
import 'package:flutter_project/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
    Task('Aprender Flutter','assets/images/FLUTTER.png', 2),
    Task('Aprender JAVA','assets/images/JAVA.png', 2),
    Task('Aprender Spring','assets/images/SPRINGBOOT.png',3),
    Task('Aprender Dart','assets/images/DART.png',4)
  ];
  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited  found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
