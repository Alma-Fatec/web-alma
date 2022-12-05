import 'package:alma_web/src/controllers/register/register_controller.dart';
import 'package:alma_web/src/controllers/register/register_state.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterButton extends StatefulWidget {
  const RegisterButton({super.key});

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    return AlmaButtonWidget(
      width: MediaQuery.of(context).size.width,
      onPressed: () => controller.createUser(),
      color: AlmaTheme.primaryColor,
      child: controller.state == RegisterState.loading
          ? const CircularProgressIndicator(color: Colors.white)
          : const AlmaText(
              text: 'Cadastrar',
              color: Colors.white,
              fontWeight: FontWeight.bold),
    );
  }
}
