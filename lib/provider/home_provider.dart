import 'package:flutter/material.dart';
import 'package:task_management/database/db_helper.dart';
import 'package:task_management/models/task_model.dart';

class HomeProvider with ChangeNotifier {
  TextEditingController searchC = TextEditingController();
  bool _isLoading = false;
  bool isShow = false;
  List<TaskModel> _tasks = [];
  List<TaskModel> completeList = [];
  List<TaskModel> incompleteList = [];

  List<TaskModel> filteredTasks = [];
  List<TaskModel> filteredComplete = [];
  List<TaskModel> filteredIncomplete = [];

  List<TaskModel> get tasksList => _tasks;
  bool get isLoading => _isLoading;
  @override
  void dispose() {
    searchC.dispose();
    super.dispose();
  }

  HomeProvider() {
    loadTasks();
  }

  void searchShowHide() {
    if (isShow == true) {
      isShow = false;
    } else {
      isShow = true;
    }
    notifyListeners();
  }

  Future<dynamic> loadTasks() async {
    _isLoading = true;
    _tasks = await DatabaseHelper.instance.fetchTasks();

    // filter list
    filteredTasks.clear();
    filteredComplete.clear();
    filteredIncomplete.clear();

// actual list
    completeList.clear();
    incompleteList.clear();

    completeList.addAll(_tasks.where((e) => e.status == true));
    incompleteList.addAll(_tasks.where((e) => e.status == false));

// list assign
    filteredTasks = List.from(_tasks);
    filteredComplete = List.from(completeList);
    filteredIncomplete = List.from(incompleteList);
    _isLoading = false;
    notifyListeners();
  }

  searchTasks(List<TaskModel> itemList, List<TaskModel> filterList) {
    String searchText = searchC.text.toLowerCase();

    if (searchText.isNotEmpty) {
      filterList.clear();
      filterList.addAll(itemList.where((item) =>
          item.title.toLowerCase().contains(searchText) ||
          item.description.toLowerCase().contains(searchText)));
    } else {
      filterList.clear();
      filterList.addAll(itemList);
    }

    notifyListeners();
  }

  void resetTaskList(List<TaskModel> taskList, List<TaskModel> filterList) {
    filterList.clear();
    filterList.addAll(taskList);
    notifyListeners();
  }

  Future<dynamic> deleteTask(int id) async {
    await DatabaseHelper.instance.deleteTask(id);
    loadTasks();
  }
}
