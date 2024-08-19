import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management/provider/task_details_provider.dart';
import 'package:task_management/style/app_colors.dart';
import 'package:task_management/style/app_text_style.dart';
import 'package:task_management/widgets/custom_elevated_btn.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int? id;
  final bool isEdite;
  bool status;
  final String title;
  final String description;
  final String createate;
  final String duedate;
  TaskDetailsScreen({
    super.key,
    this.id,
    required this.isEdite,
    required this.status,
    required this.title,
    required this.description,
    required this.createate,
    required this.duedate,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskDetailsProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
              )),
          backgroundColor: AppColors.secondaryColor,
          title: Text(
            "Task Details",
            style: AppTextStyle.ts22BW,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                createate,
                style: AppTextStyle.ts14MW,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Title:    ",
                              style: AppTextStyle.ts16BB,
                              children: [
                            TextSpan(
                              text: title,
                              style: AppTextStyle.ts16MB,
                            )
                          ])),
                      const SizedBox(height: 8.0),
                      RichText(
                          text: TextSpan(
                              text: "Task End Date:    ",
                              style: AppTextStyle.ts16BB,
                              children: [
                            TextSpan(
                              text: duedate,
                              style: AppTextStyle.ts16MB,
                            )
                          ])),
                      const SizedBox(height: 8.0),
                      RichText(
                          text: TextSpan(
                              text: "Description:    ",
                              style: AppTextStyle.ts14MB,
                              children: [
                            TextSpan(
                              text: description,
                              style: AppTextStyle.ts14RB,
                            )
                          ])),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: CustomElevatedBtn(
                    title: status == true ? "Task Incomplete" : "Task Complete",
                    bgColor: AppColors.primaryColor,
                    onTap: () {
                      if (status == true) {
                        status = false;
                      } else {
                        status = true;
                      }
                      provider
                          .updateTask(context, id!, title, description, status,
                              createate, duedate)
                          .then((onValue) {
                        provider.loadTasks();
                      });
                    }),
              )
            ],
          ),
        ),
      );
    });
  }
}
