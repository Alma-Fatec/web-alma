import 'package:alma_web/src/controllers/profile/profile_controller.dart';
import 'package:alma_web/src/controllers/profile/profile_state.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    if (controller.state == ProfileState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AlmaTextWidget(
            text: "Nome",
            color: AlmaTheme.blackAlmaColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          AlmaTextWidget(
            text: controller.user.name!,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),

          const SizedBox(height: 12),
          const AlmaTextWidget(
            text: "E-mail",
            color: AlmaTheme.blackAlmaColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          AlmaTextWidget(
            text: controller.user.email!,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),

          const SizedBox(height: 12),
          const AlmaTextWidget(
            text: "CPF",
            color: AlmaTheme.blackAlmaColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          AlmaTextWidget(
            text: controller.user.cpf!,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),

          const SizedBox(height: 12),
          const AlmaTextWidget(
            text: "Telefone",
            color: AlmaTheme.blackAlmaColor,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          AlmaTextWidget(
            text: controller.user.phone ?? "Não encontrado",
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ],
      );
    }
  }
}
