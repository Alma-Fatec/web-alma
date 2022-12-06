import 'package:alma_web/src/controllers/list_class/list_class_controller.dart';
import 'package:alma_web/src/controllers/list_class/list_class_state.dart';
import 'package:alma_web/src/pages/list_class/widgets/list_class_widget.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/utils/snackbar.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClassPage extends StatefulWidget {
  const ListClassPage({super.key});

  @override
  State<ListClassPage> createState() => _ListClassPageState();
}

class _ListClassPageState extends State<ListClassPage> {
  late ListClassController controller;

  @override
  void initState() {
    controller = context.read<ListClassController>();

    controller.addListener(() {
      if (controller.state == ListClassState.error) {
        showSnackBar(context, 'Não foi possível carregar a lista de aulas!');
      } else if (controller.state == ListClassState.success) {
        showSnackBar(context, 'Lista carregada com sucesso!');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: 'ALMA',
      floatingActionButon: FloatingActionButton.extended(
        onPressed: () => controller.refresh(),
        backgroundColor: Colors.green,
        label: const AlmaText(text: 'Recarregar'),
        icon: const Icon(Icons.refresh),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 400,
                child: AlmaTextField(
                  hintText: 'Pesquisar aula',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              AlmaButtonWidget(
                onPressed: () => Navigator.pushNamed(context, Routes.classes),
                iconData: Icons.add_circle_outline,
                color: AlmaTheme.primaryColor,
                width: 220,
                child: const AlmaText(text: 'Criar aula'),
              )
            ],
          ),
          const SizedBox(height: 20),
          const ListClassWidget(),
          Row(
            children: [
              TextButton(
                onPressed: () => controller.nextPage(),
                child: const AlmaText(text: 'Anterior'),
              ),
              TextButton(
                onPressed: () => controller.backPage(),
                child: const AlmaText(text: 'Próximo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
