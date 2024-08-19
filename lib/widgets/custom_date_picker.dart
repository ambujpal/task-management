import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final String lableText;
  final TextEditingController dateController;
  const CustomDatePicker(
      {super.key, required this.lableText, required this.dateController});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  // @override
  // void dispose() {
  //   widget.dateController.dispose();
  //   super.dispose();
  // }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.dateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      decoration: InputDecoration(
        hintText: "Select",
        labelText: widget.lableText,
        suffixIcon: const Icon(Icons.calendar_month_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        await _selectDate(context);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
    );
  }
}
