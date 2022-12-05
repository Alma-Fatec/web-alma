import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/controllers/assignment/assignment_sate.dart';
import 'package:alma_web/src/pages/assignment/widgets/files_picked_list.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/utils/snackbar.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/form_pages_structure.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
  late AssignmentController controller;
  final TextEditingController _ctrlNome = TextEditingController();
  final TextEditingController _ctrlTitulo = TextEditingController();
  final TextEditingController _ctrlDescricao = TextEditingController();

  @override
  void initState() {
    controller = context.read<AssignmentController>();

    controller.addListener(() {
      if (controller.state == AssignmentState.error) {
        showSnackBar(context, 'Não foi possível salvar a atividade!');
      } else if (controller.state == AssignmentState.success) {
        clearFields();
        showSnackBar(context, 'Atividade salva com sucesso!', durationMilli: 1000);
      }
    });
    super.initState();
  }

  void clearFields() {
    _ctrlNome.clear();
    _ctrlTitulo.clear();
    _ctrlDescricao.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: "ALMA",
      child: FormPagesStructure(
        title: "Nova atividade",
        routeToBack: Routes.listAssignments,
        buttonSave: Consumer<AssignmentController>(
          builder: (context, value, child) => AlmaButtonWidget(
            onPressed: () => value.createAssignment(),
            width: 130,
            iconData: Icons.add_circle_outline,
            color: Colors.green,
            child: AlmaText(
                text: value.state == AssignmentState.loading
                    ? 'Salvando'
                    : 'Salvar'),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AlmaTextField(
                    label: 'Titulo da atividade',
                    hintText: 'Digite um titulo',
                    labelColor: AlmaTheme.blackAlmaColor,
                    onChanged: (value) => controller.title = value,
                  ),
                  const SizedBox(height: 12),
                  AlmaTextField(
                    label: 'Nome da atividade',
                    hintText: 'Digite um nome',
                    labelColor: AlmaTheme.blackAlmaColor,
                    onChanged: (value) => controller.name = value,
                  ),
                  const SizedBox(height: 12),
                  AlmaTextField(
                    label: 'Descrição',
                    hintText: 'Descreva a atividade',
                    maxLines: 7,
                    labelColor: AlmaTheme.blackAlmaColor,
                    onChanged: (value) => controller.description = value,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AlmaButtonWidget(
                    onPressed: () => controller.pickFiles(),
                    color: AlmaTheme.primaryColor,
                    iconData: Icons.folder_copy_outlined,
                    child: const AlmaText(text: 'Selecionar arquivo'),
                  ),
                  const SizedBox(height: 12),
                  const FilesPickedList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
