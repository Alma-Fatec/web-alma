import 'package:alma_web/src/controllers/user/user_controller.dart';
import 'package:alma_web/src/controllers/user/user_state.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AlmaTextWidget(
                text: 'Não foi possível carregar a lista de usuários!'),
          ),
        );
      } else if (controller.state == UserState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1000),
            content: AlmaTextWidget(text: 'Lista carregada com sucesso!'),
          ),
        );
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
            children:  [
              const SizedBox(
                width: 400,
                child: AlmaTextField(
                  hintText: 'Pesquisar alunos',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              AlmaButtonWidget(
                onPressed: () => Navigator.pushNamed(context, Routes.newAssignment),
                iconData: Icons.add_circle_outline,
                color: AlmaTheme.primaryColor,
                width: 220,
                child: const AlmaTextWidget(text: 'Cadastrar aluno'),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Consumer<UserController>(
              builder: (context, value, child) {
                if (value.state == UserState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AlmaTheme.primaryColor,
                    ),
                  );
                } else if (value.users.isEmpty) {
                  return const Center(
                    child: AlmaTextWidget(
                      text: 'Nenhum item encontrado na lista',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) => Card(
                      color: AlmaTheme.greyAlmaColor,
                      child: ListTile(
                        title: AlmaTextWidget(
                          text: controller.users[index].name!,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        subtitle: AlmaTextWidget(
                          text:
                              controller.users[index].email!,
                          fontWeight: FontWeight.w600,
                        ),
                        onTap: () {},
                        trailing: AlmaButtonWidget(
                          onPressed: () {},
                          height: 40,
                          width: 60,
                          color: AlmaTheme.secondaryColor,
                          child: const Icon(CupertinoIcons.delete),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
