import 'package:alma_web/src/controllers/profile/profile_controller.dart';
import 'package:alma_web/src/controllers/profile/profile_state.dart';
import 'package:alma_web/src/pages/profile/widgets/profile_info_widget.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/utils/snackbar.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController controller;

  @override
  void initState() {
    controller = context.read<ProfileController>();

    controller.addListener(() {
      if (controller.state == ProfileState.error) {
        showSnackBar(context, 'Não foi possível carregar as informações do usuário!');
      } else if (controller.state == ProfileState.success) {
        showSnackBar(context, 'Informações do usuário carregadas com sucesso!', durationMilli: 1000);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: "ALMA",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          AlmaText(
            text: "Informações do usuário",
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AlmaTheme.actionColor,
          ),
          SizedBox(height: 10),
          ProfileInfoWidget(),
        ],
      ),
    );
  }
}
