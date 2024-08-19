import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management/database/db_helper.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/utils/utils.dart';

class CreateTaskProvider with ChangeNotifier {
  late bool isEdite;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int id = 0;
  TextEditingController titlC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  List<TaskModel> _tasks = [];
  List<TaskModel> get tasks => _tasks;

  loadTasks() async {
    _tasks = await DatabaseHelper.instance.fetchTasks();
    notifyListeners();
  }

  bool validation(BuildContext context) {
    if (titlC.text.isEmpty || titlC.text == "") {
      Utils.errorMessage(context, "Enter the title");
      return false;
    } else if (descriptionC.text.isEmpty || descriptionC.text == "") {
      Utils.errorMessage(context, "Enter description");
      return false;
    } else if (dateC.text.isEmpty || dateC.text == "") {
      Utils.errorMessage(context, "Select due date");
      return false;
    } else {
      return true;
    }
  }

  bool dateValidation(BuildContext context) {
    final String selectDate = dateC.text;

    if (selectDate.isEmpty) {
      return true;
    }

    try {
      final DateTime selectedDate = DateFormat('dd-MM-yyyy').parse(selectDate);
      final DateTime today = DateTime.now();

      if (selectedDate.isBefore(today)) {
        dateC.clear();
        Utils.errorMessage(context, "Can't select a previous date");
        return false;
      }

      return true;
    } catch (e) {
      dateC.clear();
      Utils.errorMessage(context, "Invalid date format");
      return false;
    }
  }

  Future<dynamic> addTask(BuildContext context) async {
    if (!validation(context)) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseHelper.instance.insertTask(TaskModel(
          title: titlC.text,
          description: descriptionC.text,
          status: false,
          createdDate: DateTime.now(),
          dueDate: DateFormat("dd-MM-yyyy").parse(dateC.text)));
      clear();
      loadTasks();

      Future.delayed(const Duration(seconds: 1), () {
        _isLoading = false;
        notifyListeners();
        Utils.succesMessage(context, "Task created succesfully");
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Utils.errorMessage(context, "$e");
    }
  }

  Future<dynamic> updateTask(BuildContext context) async {
    if (!validation(context)) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      await DatabaseHelper.instance.updateTask(TaskModel(
          id: id,
          title: titlC.text,
          description: descriptionC.text,
          status: false,
          createdDate: DateTime.now(),
          dueDate: DateFormat("dd-MM-yyyy").parse(dateC.text)));

      Future.delayed(const Duration(seconds: 1), () {
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        Utils.succesMessage(context, "Task updated succesfully");
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      Utils.errorMessage(context, "$e");
    }
  }

  void clear() {
    titlC.clear();
    descriptionC.clear();
    dateC.clear();
  }

  @override
  void dispose() {
    dateC.dispose();
    descriptionC.dispose();
    titlC.dispose();
    super.dispose();
    notifyListeners();
  }
}
