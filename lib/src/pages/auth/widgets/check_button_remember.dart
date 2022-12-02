import 'package:alma_web/src/controllers/auth/auth_controller.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckButtonRemember extends StatelessWidget {
  const CheckButtonRemember({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: controller.checked,
          onChanged: (value) => controller.toggleCheckRemember(value!),
          fillColor: MaterialStateProperty.all(AlmaTheme.secondaryColor),
          checkColor: Colors.white,
        ),
        const AlmaTextWidget(text: 'Lembrar senha', color: Colors.white),
      ],
    );
  }
}
