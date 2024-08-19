import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_management/provider/create_task_provider.dart';
import 'package:task_management/style/app_colors.dart';
import 'package:task_management/style/app_text_style.dart';
import 'package:task_management/widgets/custom_date_picker.dart';
import 'package:task_management/widgets/custom_elevated_btn.dart';
import 'package:task_management/widgets/custom_textformfield.dart';

class TaskCreateScreen extends StatelessWidget {
  final int? id;
  final bool isEdite;
  final String title;
  final String description;
  final String duedate;
  const TaskCreateScreen({
    super.key,
    this.id,
    required this.isEdite,
    required this.title,
    required this.description,
    required this.duedate,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateTaskProvider>(builder: (context, provider, child) {
      provider.id = id ?? 0;
      provider.titlC.text = title;
      provider.descriptionC.text = description;
      provider.dateC.text = duedate;
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                provider.clear();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppColors.white,
              )),
          backgroundColor: AppColors.secondaryColor,
          title: Text(
            isEdite ? "Update Task" : "Create New Task",
            style: AppTextStyle.ts22BW,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 50.0),
                CustomTextFormField(
                  controller: provider.titlC,
                  labelText: "Title *",
                  hintText: "Enter the title",
                ),
                const SizedBox(height: 30.0),
                CustomTextFormField(
                  controller: provider.descriptionC,
                  labelText: "Description *",
                  hintText: "Enter the description",
                ),
                const SizedBox(height: 30.0),
                CustomDatePicker(
                  lableText: "Due Date *",
                  dateController: provider.dateC,
                ),
                const SizedBox(height: 50.0),
                CustomElevatedBtn(
                  title: isEdite ? "Update" : "Add",
                  bgColor: AppColors.primaryColor,
                  indicatorColor: AppColors.white,
                  isLoading: provider.isLoading,
                  onTap: () async {
                    if (!provider.dateValidation(context)) {
                      return;
                    }

                    if (isEdite) {
                      await provider.updateTask(context);
                    } else {
                      await provider.addTask(context);
                    }
                  },
                )
              ],
            ),
          )),
        ),
      );
    });
  }
}
