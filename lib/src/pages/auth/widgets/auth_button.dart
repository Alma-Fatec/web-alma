import 'package:alma_web/src/controllers/auth/auth_controller.dart';
import 'package:alma_web/src/controllers/auth/auth_sate.dart';
import 'package:alma_web/src/data/models/auth/auth_model.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    return AlmaButtonWidget(
      width: MediaQuery.of(context).size.width,
      onPressed: () => controller.authAction(),
      color: AlmaTheme.primaryColor,
      child: controller.state == AuthState.authenticanting
          ? const CircularProgressIndicator(color: Colors.white)
          : const AlmaText(text: 'Entrar', color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
