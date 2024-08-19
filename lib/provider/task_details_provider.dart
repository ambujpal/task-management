import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/database/db_helper.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/utils.dart';

class TaskDetailsProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  loadTasks() async {
    _tasks = await DatabaseHelper.instance.fetchTasks();
    notifyListeners();
  }

  Future<dynamic> updateTask(
      BuildContext context,
      int id,
      String title,
      String description,
      bool status,
      String createdDate,
      String dueDate) async {
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseHelper.instance.updateTask(TaskModel(
          id: id,
          title: title,
          description: description,
          status: status,
          createdDate:
              DateFormat("dd-MM-yyyy").parse(DateTime.now().toString()),
          dueDate: DateFormat("dd-MM-yyyy").parse(dueDate)));

      Future.delayed(const Duration(seconds: 1), () {
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        status == false
            ? Utils.succesMessage(context, "Task Incompleted Succesfully")
            : Utils.succesMessage(context, "Task Completed succesfully");
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Utils.errorMessage(context, "$e");
    }
  }
}
