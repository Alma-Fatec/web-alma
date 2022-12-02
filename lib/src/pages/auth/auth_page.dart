import 'package:alma_web/src/controllers/auth/auth_controller.dart';
import 'package:alma_web/src/controllers/auth/auth_sate.dart';
import 'package:alma_web/src/pages/auth/widgets/auth_button.dart';
import 'package:alma_web/src/pages/auth/widgets/check_button_remember.dart';
import 'package:alma_web/src/pages/auth/widgets/text_field_password.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthController controller;
  
  @override
  void initState() {
    controller = context.read<AuthController>();

    controller.addListener(() {
      if (controller.state == AuthState.errorAuth) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AlmaTextWidget(
              text:
                  controller.message ?? 'Erro ao fazer a autenticação!',
            ),
          ),
        );
      } else if (controller.state == AuthState.successAuth) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(milliseconds: 1000),
            content: AlmaTextWidget(text: controller.message!),
          ),
        );
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlmaTheme.actionColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AlmaTextWidget(
                  text: 'BEM-VINDO',
                  fontWeight: FontWeight.w600,
                  fontSize: 44,
                ),
                const SizedBox(height: 40),
                AlmaTextField(
                  hintText: 'Seu e-mail',
                  label: 'E-mail',
                  onChanged: (value) => controller.email = value,
                ),
                const SizedBox(height: 20),
                const TextFieldPassword(),
                const SizedBox(height: 30),
                const CheckButtonRemember(),
                const SizedBox(height: 30),
                const AuthButton(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.register),
                      child: const AlmaTextWidget(
                          text: 'Não tem uma conta?',
                          color: AlmaTheme.greyAlmaColor),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const AlmaTextWidget(
                          text: 'Esqueceu sua senha?',
                          color: AlmaTheme.greyAlmaColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          const SidebarWidget(),
        ],
      ),
    );
  }
}
