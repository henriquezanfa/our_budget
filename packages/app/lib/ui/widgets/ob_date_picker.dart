import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ob/ui/widgets/widgets.dart';

class OBDatePicker extends StatefulWidget {
  const OBDatePicker({
    required this.onDateSelected,
    super.key,
    this.selectedDate,
  });

  final DateTime? selectedDate;
  final void Function(DateTime) onDateSelected;

  @override
  State<OBDatePicker> createState() => _OBDatePickerState();
}

class _OBDatePickerState extends State<OBDatePicker> {
  @override
  Widget build(BuildContext context) {
    return OBTextField(
      readOnly: true,
      labelText: 'Date',
      onTap: () async {
        final date = await showAdaptiveDatePicker(
          context: context,
          initialDate: widget.selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          widget.onDateSelected(date);
        }
      },
      controller: TextEditingController(
        text: widget.selectedDate?.toIso8601String().split('T').first,
      ),
    );
  }
}

Future<DateTime?> showAdaptiveDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  if (Platform.isAndroid) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  if (Platform.isIOS) {
    return showCupertinoModalPopup(
      context: context,
      builder: (_) => const CupertinoDateTimePicker(),
    );
  }

  throw UnimplementedError();
}

class CupertinoDateTimePicker extends StatefulWidget {
  const CupertinoDateTimePicker({
    this.initialDate,
    super.key,
  });
  final DateTime? initialDate;

  @override
  State<CupertinoDateTimePicker> createState() =>
      _CupertinoDateTimePickerState();
}

class _CupertinoDateTimePickerState extends State<CupertinoDateTimePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      child: Container(
        height: 350,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(_selectedDate);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 18,
                      color: colors.secondary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 250,
              child: CupertinoDatePicker(
                initialDateTime: widget.initialDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (val) {
                  setState(() {
                    _selectedDate = val;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
