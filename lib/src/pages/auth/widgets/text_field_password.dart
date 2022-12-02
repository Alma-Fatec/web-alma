import 'package:alma_web/src/controllers/auth/auth_controller.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldPassword extends StatelessWidget {
  const TextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();

    return AlmaTextField(
      hintText: '********',
      label: 'Senha',
      obscureText: controller.obscurePassword,
      onChanged: (value) => controller.password = value,
      suffixIcon: IconButton(
        onPressed: () => controller.seePasswordAction(),
        icon: const Icon(Icons.lock, color: AlmaTheme.actionColor),
      ),
    );
  }
}
