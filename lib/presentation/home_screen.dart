import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_management/models/task_model.dart';
import 'package:task_management/presentation/task_create_screen.dart';
import 'package:task_management/presentation/task_details_screen.dart';
import 'package:task_management/provider/home_provider.dart';
import 'package:task_management/style/app_colors.dart';
import 'package:task_management/style/app_text_style.dart';
import 'package:task_management/utils/utils.dart';
import 'package:task_management/widgets/custom_search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondaryColor,
          title: Text(
            "Task Management",
            style: AppTextStyle.ts22BW,
          ),
          actions: [
            IconButton(
                onPressed: provider.searchShowHide,
                icon: Icon(
                  Icons.search,
                  color: AppColors.white,
                )),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskCreateScreen(
                      isEdite: false,
                      title: "",
                      description: "",
                      duedate: "",
                    ),
                  ),
                ).then((value) {
                  provider.loadTasks();
                });
              },
              child: Text(
                "Add",
                style: AppTextStyle.ts16BW,
              ),
            )
          ],
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  unselectedLabelStyle: AppTextStyle.ts16RB,
                  labelStyle: AppTextStyle.ts16BB,
                  labelColor: Colors.cyan,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.cyan,
                  tabs: const [
                    Tab(text: "All"),
                    Tab(text: "Complete"),
                    Tab(text: "Incomplete"),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    child: TabBarView(
                      children: [
                        taskListView(provider, provider.tasksList,
                            provider.filteredTasks),
                        taskListView(provider, provider.completeList,
                            provider.filteredComplete),
                        taskListView(provider, provider.incompleteList,
                            provider.filteredIncomplete),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget taskListView(HomeProvider provider, List<TaskModel> taskList,
      List<TaskModel> filterList) {
    return Column(
      children: [
        provider.isShow
            ? CustomSearchField(
                searchC: provider.searchC,
                isShowCancelIcon: true,
                onValueChangeFunction: (value) {
                  provider.searchTasks(taskList, filterList);
                },
                onCancelCallbackFunction: () {
                  provider.searchC.clear();
                  provider.resetTaskList(taskList, filterList);
                },
                hintText: "Search here...",
              )
            : const SizedBox(),
        const SizedBox(height: 15.0),
        Expanded(
          child: provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : filterList.isEmpty
                  ? Center(
                      child: Text(
                        "No tasks found!",
                        style: AppTextStyle.ts18MB,
                      ),
                    )
                  : ListView.builder(
                      itemCount: filterList.length,
                      itemBuilder: (context, index) {
                        return taskCard(provider, context, filterList, index);
                      },
                    ),
        ),
      ],
    );
  }

  Widget taskCard(HomeProvider provider, BuildContext context,
      List<TaskModel> filterList, int index) {
    final task = filterList[index];

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(
              isEdite: true,
              title: task.title,
              description: task.description,
              duedate: DateFormat("dd-MM-yyyy").format(task.dueDate),
              id: task.id!,
              createate: DateFormat("dd-MM-yyyy").format(task.createdDate),
              status: task.status,
            ),
          ),
        ).then((value) {
          provider.loadTasks();
        });
      },
      child: Card(
        elevation: 3,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTextStyle.ts14MB,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      task.description,
                      style: AppTextStyle.ts12RB,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('MMM d, yyyy').format(task.createdDate),
                    style: AppTextStyle.ts12RB,
                  ),
                  PopupMenuButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.edit),
                          title: Text(
                            "Edit",
                            style: AppTextStyle.ts14RB,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskCreateScreen(
                                  isEdite: true,
                                  title: task.title,
                                  description: task.description,
                                  duedate: DateFormat("dd-MM-yyyy")
                                      .format(task.dueDate),
                                  id: task.id!,
                                ),
                              ),
                            ).then((value) {
                              provider.loadTasks();
                            });
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.delete),
                          title: Text(
                            "Delete",
                            style: AppTextStyle.ts14RB,
                          ),
                          onTap: () async {
                            await deleteTaskDialog(context, task.id!)
                                .then((onValue) {
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteTaskDialog(BuildContext context, int id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(10.0),
          title: const Text(""),
          content: const Text(
            "Are you sure you want to delete?",
            style: TextStyle(fontSize: 18.0),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: Text(
                    "Cancel",
                    style: AppTextStyle.ts16BB,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    "Delete",
                    style: AppTextStyle.ts16BB.copyWith(color: Colors.red),
                  ),
                  onPressed: () async {
                    await Provider.of<HomeProvider>(context, listen: false)
                        .deleteTask(id)
                        .then((value) {
                      Navigator.pop(context);
                    });
                    Utils.succesMessage(context, "Task deleted successfully");
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
