import 'package:alma_web/src/controllers/register/register_controller.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckButtonTerms extends StatelessWidget {
  const CheckButtonTerms({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<RegisterController>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: controller.checked,
          onChanged: (value) => controller.toggleCheckTerms(value!),
          fillColor: MaterialStateProperty.all(AlmaTheme.secondaryColor),
          checkColor: Colors.white,
        ),
        RichText(
          text: const TextSpan(
            text: "Eu aceito os ",
            style: TextStyle(
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: "Termos e Política de Privacidade ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text: "do site",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
