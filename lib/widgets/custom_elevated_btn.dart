import 'package:flutter/material.dart';
import 'package:task_management/style/app_text_style.dart';

// ignore: must_be_immutable
class CustomElevatedBtn extends StatelessWidget {
  String title;

  Color? bgColor;
  bool isLoading;
  VoidCallback? onTap;
  Color? indicatorColor;
  CustomElevatedBtn({
    super.key,
    required this.title,
    this.bgColor,
    this.onTap,
    this.isLoading = false,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
        ),
        onPressed: onTap,
        child: isLoading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: indicatorColor,
                  ),
                ),
              )
            : Text(title, style: AppTextStyle.ts18BW),
      ),
    );
  }
}
