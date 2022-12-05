import 'package:alma_web/src/controllers/class_block/class_block_controller.dart';
import 'package:alma_web/src/controllers/class_block/class_block_state.dart';
import 'package:alma_web/src/pages/class_block/widgets/dialog_select_students.dart';
import 'package:alma_web/src/pages/class_block/widgets/files_picked_list.dart';
import 'package:alma_web/src/pages/class_block/widgets/list_users_selected.dart';
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

class ClassBlockPage extends StatefulWidget {
  const ClassBlockPage({super.key});

  @override
  State<ClassBlockPage> createState() => _ClassBlockPageState();
}

class _ClassBlockPageState extends State<ClassBlockPage> {
  late ClassBlockController controller;
  final TextEditingController _ctrlTitulo = TextEditingController();
  final TextEditingController _ctrlDescricao = TextEditingController();

  @override
  void initState() {
    controller = context.read<ClassBlockController>();

    controller.addListener(() {
      if (controller.state == ClassBlockState.error) {
        showSnackBar(context, 'Não foi possível salvar o bloco de aula!');
      } else if (controller.state == ClassBlockState.success) {
        clearFields();
        showSnackBar(context, 'Bloco de aula salvo com sucesso!', durationMilli: 1000);
      }
    });

    super.initState();
  }

  void clearFields() {
    _ctrlTitulo.clear();
    _ctrlDescricao.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: 'Novo bloco de aulas',
      child: FormPagesStructure(
        title: "Novo bloco de aulas",
        routeToBack: Routes.listBlocks,
        buttonSave: Consumer<ClassBlockController>(
          builder: (context, value, child) => AlmaButtonWidget(
            onPressed: () => value.saveClassBlock(),
            width: 130,
            iconData: Icons.add_circle_outline,
            color: Colors.green,
            child: AlmaText(
                text: value.state == ClassBlockState.loading
                    ? 'Salvando'
                    : 'Salvar'),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AlmaTextField(
                        controller: _ctrlTitulo,
                        label: 'Titulo do bloco de aulas',
                        hintText: 'Digite um titulo',
                        labelColor: AlmaTheme.blackAlmaColor,
                        onChanged: (value) => controller.title = value,
                      ),
                      const SizedBox(height: 12),
                      AlmaTextField(
                        controller: _ctrlDescricao,
                        label: 'Descrição',
                        hintText: 'Descreva o bloco de aulas',
                        maxLines: 7,
                        labelColor: AlmaTheme.blackAlmaColor,
                        onChanged: (value) => controller.description = value,
                      ),
                      const SizedBox(height: 12),
                      AlmaButtonWidget(
                        onPressed: () => _openDialog(),
                        color: AlmaTheme.actionColor,
                        iconData: Icons.add_circle_outline,
                        child: const AlmaText(text: "Adicionar alunos"),
                      ),
                      const SizedBox(height: 12),
                      const ListUserSelected(),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
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
          ],
        ),
      ),
    );
  }

  void _openDialog() {
    showDialog(
        context: context, builder: (context) => const DialogSelecStudents());
  }
}
