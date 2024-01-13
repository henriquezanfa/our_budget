import 'package:flutter/material.dart';
import 'package:ob/ui/widgets/widgets.dart';

class OBFieldSelection extends StatefulWidget {
  const OBFieldSelection({
    required this.labelText,
    required this.items,
    required this.onSelectionChanged,
    super.key,
    this.initialSelectedItem,
  });
  final String labelText;
  final List<String> items;
  final String? initialSelectedItem;
  final void Function(String?) onSelectionChanged;

  @override
  State<OBFieldSelection> createState() => _OBFieldSelectionState();
}

class _OBFieldSelectionState extends State<OBFieldSelection> {
  String? _selectedText;

  @override
  void initState() {
    super.initState();
    _selectedText = widget.initialSelectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return OBTextField(
      readOnly: true,
      labelText: widget.labelText,
      onTap: () async {
        final selectedTag = await showModalBottomSheet<String>(
          context: context,
          builder: (context) => OBItemSelection(
            items: widget.items,
            initialSelectedItem: widget.initialSelectedItem,
          ),
        );
        setState(() => _selectedText = selectedTag);
        widget.onSelectionChanged(_selectedText);
      },
      controller: TextEditingController(text: _selectedText),
    );
  }
}

class OBItemSelection extends StatefulWidget {
  const OBItemSelection({
    required this.items,
    this.initialSelectedItem,
    super.key,
  });

  final List<String> items;
  final String? initialSelectedItem;

  @override
  State<OBItemSelection> createState() => _OBItemSelectionState();
}

class _OBItemSelectionState extends State<OBItemSelection> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isSelected = widget.initialSelectedItem == item;

        return ListTile(
          title: Text(item),
          trailing: isSelected ? const Icon(Icons.check) : null,
          onTap: () => Navigator.of(context).pop(item),
        );
      },
    );
  }
}
