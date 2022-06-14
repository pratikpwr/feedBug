import 'package:flutter/material.dart';

import '../../../extension/context_extension.dart';
import 'padding.dart';

class DropdownItem<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final Function(T?) onChanged;
  final String Function(T)? itemToString;
  final Widget? dropdownIcon;
  final String? hint;

  String _defaultItemToString(T item) => item.toString();

  const DropdownItem({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.itemToString,
    this.dropdownIcon,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hint == null) {
      return _buildDropDown();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint!,
            style: context.theme.textTheme.titleMedium,
          ),
          padding4,
          _buildDropDown(),
        ],
      );
    }
  }

  Widget _buildDropDown() {
    return InputDecorator(
      expands: false,

      decoration: const InputDecoration(
          border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isDense: true,
          isExpanded: true,
          items: List<DropdownMenuItem<T>>.generate(items.length, (index) {
            return DropdownMenuItem<T>(
              value: items[index],
              child: Text(itemToString != null
                  ? itemToString!(items[index])
                  : _defaultItemToString(items[index])),
            );
          }),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
