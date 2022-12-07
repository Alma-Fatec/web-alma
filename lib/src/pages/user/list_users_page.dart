import 'package:alma_web/src/controllers/user/user_controller.dart';
import 'package:alma_web/src/controllers/user/user_state.dart';
import 'package:alma_web/src/pages/user/widgets/list_users_widget.dart';
import 'package:alma_web/src/utils/snackbar.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUsersPage extends StatefulWidget {
  const ListUsersPage({super.key});

  @override
  State<ListUsersPage> createState() => _ListUsersPageState();
}

class _ListUsersPageState extends State<ListUsersPage> {
  late UserController controller;

  @override
  void initState() {
    controller = context.read<UserController>();

    controller.addListener(() {
      if (controller.state == UserState.error) {
        showSnackBar(context, 'Não foi possível carregar a lista de usuários!');
      } else if (controller.state == UserState.success) {
        showSnackBar(context, 'Lista carregada com sucesso!', durationMilli: 1000);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: 'ALMA',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 400,
                child: AlmaTextField(
                  hintText: 'Pesquisar alunos',
                  prefixIcon: const Icon(Icons.search),
                  onChanged: (query) => controller.filterSearchResults(query),
                ),
              ),
              /* AlmaButtonWidget(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.newAssignment),
                iconData: Icons.add_circle_outline,
                color: AlmaTheme.primaryColor,
                width: 220,
                child: const AlmaText(text: 'Cadastrar aluno'),
              ) */
            ],
          ),
          const SizedBox(height: 20),
          const ListUsersWidget(),
          const SizedBox(height: 20),
          Row(
            children: [
              TextButton(
                onPressed: () => controller.backPage(),
                child: const AlmaText(text: 'Anterior'),
              ),
              TextButton(
                onPressed: () => controller.nextPage(),
                child: const AlmaText(text: 'Próximo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
