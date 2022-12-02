import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';

class AlmaTextField extends StatelessWidget {
  const AlmaTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmited,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.maxLines,
    this.labelColor,
    this.maxLength,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmited;
  final String? hintText;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final int? maxLines;
  final Color? labelColor;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? Container()
            : Column(
                children: [
                  AlmaTextWidget(
                    text: label!,
                    color: labelColor ?? Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          onFieldSubmitted: onSubmited,
          obscureText: obscureText ?? false,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0),
              borderSide: const BorderSide(
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
