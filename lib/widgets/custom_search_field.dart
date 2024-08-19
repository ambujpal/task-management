import 'package:flutter/material.dart';
import 'package:task_management/style/app_colors.dart';
import 'package:task_management/style/app_text_style.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController searchC;
  final bool isShowCancelIcon;
  final Function(String) onValueChangeFunction;
  final Function() onCancelCallbackFunction;
  final String hintText;
  const CustomSearchField({
    super.key,
    required this.searchC,
    required this.isShowCancelIcon,
    required this.onValueChangeFunction,
    required this.onCancelCallbackFunction,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: CommonFunction.getActualWidth(context) - 20.0,
      child: TextField(
        style: AppTextStyle.ts16MB,
        controller: searchC,
        onChanged: onValueChangeFunction,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: AppTextStyle.ts16MB,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                !isShowCancelIcon
                    ? Container()
                    : InkWell(
                        onTap: onCancelCallbackFunction,
                        child: Icon(
                          Icons.cancel,
                          size: 20.0,
                          color: AppColors.black,
                        ),
                      ),
                const SizedBox(width: 5.0),
                Container(
                  width: 1.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(width: 5.0),
                Icon(
                  Icons.search,
                  color: AppColors.black,
                  size: 20.0,
                ),
              ],
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
