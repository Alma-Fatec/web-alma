import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/data/enum/assignment_type.dart';
import 'package:alma_web/src/pages/assignment/widgets/files_picked_list.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownAssignmentType extends StatelessWidget {
  const DropdownAssignmentType({super.key, required this.ctrlDescricao, required this.ctrlAnswer});

  final TextEditingController ctrlDescricao;
  final TextEditingController ctrlAnswer;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AssignmentController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<AssignmentType>(
          value: controller.assignmentType,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          isExpanded: true,
          style: const TextStyle(color: AlmaTheme.actionColor),
          underline: Container(
            height: 2,
            color: AlmaTheme.actionColor,
          ),
          onChanged: (value) => controller.setAssignmentType(value!),
          items: controller.listKind
              .map<DropdownMenuItem<AssignmentType>>(
                (AssignmentType value) => DropdownMenuItem<AssignmentType>(
                  value: value,
                  child: AlmaText(text: controller.formatAssignmentType(value)),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        if (controller.assignmentType ==
            AssignmentType.ALTERNATIVA_COM_AUDIO) ...[
          AlmaTextField(
            label: 'Descrição do áudio',
            hintText: 'Descreva o áudio da atividade',
            controller: ctrlDescricao,
            maxLines: 7,
            labelColor: AlmaTheme.blackAlmaColor,
            onChanged: (value) => controller.description = value,
          ),
        ] else if (controller.assignmentType ==
            AssignmentType.ALTERNATIVA_COM_IMAGENS) ...[
          AlmaButtonWidget(
            onPressed: () => controller.pickFiles(),
            color: AlmaTheme.primaryColor,
            iconData: Icons.folder_copy_outlined,
            child: const AlmaText(text: 'Selecionar arquivo'),
          ),
          const SizedBox(height: 12),
          const FilesPickedList(),
        ] else if (controller.assignmentType == AssignmentType.DIGITACAO) ...[
          AlmaTextField(
            controller: ctrlAnswer,
            label: 'Resposta',
            hintText: 'Digite a resposta da atividade com digitação',
            maxLines: 7,
            labelColor: AlmaTheme.blackAlmaColor,
            onChanged: (value) => controller.answer = value,
          ),
        ] else ...[
          Container(),
        ]
      ],
    );
  }
}
