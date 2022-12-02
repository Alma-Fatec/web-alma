import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';

class FormPagesStructure extends StatelessWidget {
  const FormPagesStructure({
    super.key,
    required this.title,
    required this.buttonSave,
    this.routeToBack,
    required this.child,
  });

  final String title;
  final Widget buttonSave;
  final String? routeToBack;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AlmaButtonWidget(
              onPressed: routeToBack == null
                  ? () => Navigator.pop(context)
                  : () => Navigator.pushReplacementNamed(context, routeToBack!, result: true),
              width: 130,
              iconData: Icons.arrow_back,
              color: AlmaTheme.primaryColor,
              child: const AlmaTextWidget(text: 'Voltar'),
            ),
            buttonSave,
          ],
        ),
        const Divider(color: AlmaTheme.blackAlmaColor),
        const SizedBox(height: 15),
        AlmaTextWidget(
          text: title,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AlmaTheme.actionColor,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: AlmaTheme.greyAlmaColor,
          ),
          child: child,
        ),
      ],
    );
  }
}
