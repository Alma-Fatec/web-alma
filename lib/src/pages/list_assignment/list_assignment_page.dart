import 'package:alma_web/src/controllers/list_assignment/list_assignment_controller.dart';
import 'package:alma_web/src/controllers/list_assignment/list_assignment_state.dart';
import 'package:alma_web/src/controllers/list_class_block/list_class_block_state.dart';
import 'package:alma_web/src/pages/list_assignment/widgets/list_assignment_widget.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAssignmentPage extends StatefulWidget {
  const ListAssignmentPage({super.key});

  @override
  State<ListAssignmentPage> createState() => _ListAssignmentPageState();
}

class _ListAssignmentPageState extends State<ListAssignmentPage> {
  late ListAssignmentController controller;

  @override
  void initState() {
    controller = context.read<ListAssignmentController>();

    controller.addListener(() {
      if (controller.state == ListAssignmentState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AlmaTextWidget(
                text: 'Não foi possível carregar a lista de atividades!'),
          ),
        );
      } else if (controller.state == ListAssignmentState.success) {
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
                  hintText: 'Pesquisar atividade',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              AlmaButtonWidget(
                onPressed: () => Navigator.pushNamed(context, Routes.newAssignment),
                iconData: Icons.add_circle_outline,
                color: AlmaTheme.primaryColor,
                width: 220,
                child: const AlmaTextWidget(text: 'Criar atividade'),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: const ListAssignmentWidget(),
          ),
        ],
      ),
    );
  }
}
