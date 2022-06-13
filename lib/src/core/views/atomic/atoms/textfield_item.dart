import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../extension/context_extension.dart';
import 'padding.dart';

class LabelledTextFieldItem extends StatelessWidget {
  const LabelledTextFieldItem({
    Key? key,
    this.title,
    this.hintText,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.focusNode,
    this.validator,
    this.textInputAction,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onChanged,
    this.inputFormatters,
    this.textAlignment = TextAlign.start,
  }) : super(key: key);

  final String? title;
  final String? hintText;
  final TextEditingController? controller;

  final int maxLines;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted, onChanged;

  final TextAlign textAlignment;

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return _buildTextField();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: context.theme.textTheme.titleMedium,
          ),
          padding4,
          _buildTextField(),
        ],
      );
    }
  }

  Widget _buildTextField() {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(borderSide: BorderSide()),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
      ),
      maxLines: maxLines,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      textAlign: textAlignment,
    );
  }
}
