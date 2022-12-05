import 'package:alma_web/src/controllers/class/class_controller.dart';
import 'package:alma_web/src/controllers/class/class_states.dart';
import 'package:alma_web/src/pages/class/widgets/dialog_select_blocks.dart';
import 'package:alma_web/src/pages/class/widgets/files_picked_list.dart';
import 'package:alma_web/src/pages/class/widgets/list_block_selected.dart';
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

class ClassPage extends StatefulWidget {
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  late ClassController controller;
  final TextEditingController _ctrlNome = TextEditingController();
  final TextEditingController _ctrlDescricao = TextEditingController();
  final TextEditingController _ctrlOrdem = TextEditingController();

  @override
  void initState() {
    controller = context.read<ClassController>();

    controller.addListener(() {
      if (controller.state == ClassStates.error) {
        showSnackBar(context, 'Não foi possível salvar a aula!');
      } else if (controller.state == ClassStates.success) {
        clearFields();
        showSnackBar(context, 'Aula salva com sucesso!', durationMilli: 1000);
      }
    });
    super.initState();
  }

  void clearFields() {
    _ctrlNome.clear();
    _ctrlOrdem.clear();
    _ctrlDescricao.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: "ALMA",
      child: FormPagesStructure(
        title: "Nova aula",
        routeToBack: Routes.listClasses,
        buttonSave: Consumer<ClassController>(
          builder: (context, value, child) => AlmaButtonWidget(
            onPressed: () => value.createClass(),
            width: 130,
            iconData: Icons.add_circle_outline,
            color: Colors.green,
            child: AlmaText(
                text:
                    value.state == ClassStates.loading ? 'Salvando' : 'Salvar'),
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
                    controller: _ctrlNome,
                    label: 'Nome da aula',
                    hintText: 'Digite um nome',
                    labelColor: AlmaTheme.blackAlmaColor,
                    onChanged: (value) => controller.name = value,
                  ),
                  const SizedBox(height: 12),
                  AlmaTextField(
                    controller: _ctrlDescricao,
                    label: 'Descrição',
                    hintText: 'Descreva a aula',
                    maxLines: 7,
                    labelColor: AlmaTheme.blackAlmaColor,
                    onChanged: (value) => controller.description = value,
                  ),
                  const SizedBox(height: 12),
                  AlmaButtonWidget(
                    width: 290,
                    onPressed: () => _openDialog(),
                    color: AlmaTheme.actionColor,
                    iconData: Icons.add_circle_outline,
                    child: const AlmaText(text: "Adicionar bloco de aula"),
                  ),
                  const SizedBox(height: 12),
                  const ListBlockSelected(),
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

  void _openDialog() {
    showDialog(
        context: context, builder: (context) => const DialogSelectBlocks());
  }
}
