import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, {int? durationMilli, SnackBarAction? action}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: AlmaText(text: message),
    action: action,
    duration: Duration(milliseconds: durationMilli ?? 4000),
  ));
}
