import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/controllers/assignment/assignment_sate.dart';
import 'package:alma_web/src/pages/assignment/widgets/dialog_add_option.dart';
import 'package:alma_web/src/pages/assignment/widgets/dialog_select_class.dart';
import 'package:alma_web/src/pages/assignment/widgets/dropdown_assignment_type.dart';
import 'package:alma_web/src/pages/assignment/widgets/list_class_selected.dart';
import 'package:alma_web/src/pages/assignment/widgets/list_options_assignments.dart';
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
  final TextEditingController _ctrlTitulo = TextEditingController();
  final TextEditingController _ctrlDescricao = TextEditingController();
  final TextEditingController _ctrlAnswer = TextEditingController();

  @override
  void initState() {
    controller = context.read<AssignmentController>();

    controller.addListener(() {
      if (controller.state == AssignmentState.error) {
        showSnackBar(context, 'Não foi possível salvar a atividade!');
      } else if (controller.state == AssignmentState.success) {
        clearFields();
        showSnackBar(context, 'Atividade salva com sucesso!',
            durationMilli: 1000);
      }
    });
    super.initState();
  }

  void clearFields() {
    _ctrlAnswer.clear();
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
                  AlmaButtonWidget(
                    width: 290,
                    onPressed: () => _openDialogCreateOptions(),
                    color: AlmaTheme.secondaryColor,
                    iconData: Icons.add_circle_outline,
                    child: const AlmaText(text: "Adicionar alternativa"),
                  ),
                  const SizedBox(height: 10),
                  const ListOptionsAssignments(),
                  
                  const SizedBox(height: 18),
                  AlmaButtonWidget(
                    width: 290,
                    onPressed: () => _openDialogClasses(),
                    color: AlmaTheme.actionColor,
                    iconData: Icons.add_circle_outline,
                    child: const AlmaText(text: "Adicionar aula"),
                  ),
                  const SizedBox(height: 10),
                  const ListClassSelected(),
                  
                  const SizedBox(height: 18),
                  DropdownAssignmentType(
                    ctrlAnswer: _ctrlAnswer,
                    ctrlDescricao: _ctrlDescricao,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDialogClasses() {
    showDialog(
        context: context, builder: (context) => const DialogSelectClass());
  }

  void _openDialogCreateOptions() {
    showDialog(
        context: context, builder: (context) => DialogAddOption());
  }
}
