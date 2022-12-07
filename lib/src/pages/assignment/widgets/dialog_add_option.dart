import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogAddOption extends StatelessWidget {
  DialogAddOption({super.key});

  final TextEditingController _ctrlTexto = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AssignmentController>();
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AlmaText(
            text: 'Adicionar alternativa',
            fontWeight: FontWeight.bold,
            color: AlmaTheme.primaryColor,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        height: 220,
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AlmaTextField(
              label: 'Texto',
              hintText: 'Digite o texto da alternativa',
              onChanged: (value) => controller.text = value,
            ),
            const SizedBox(height: 10),
            DropdownButton<bool>(
              value: controller.isCorrect,
              icon: const Icon(Icons.arrow_downward),
              hint: const AlmaText(text: 'Selecione se a alternativa é a correta'),
              elevation: 16,
              isExpanded: true,
              style: const TextStyle(color: AlmaTheme.actionColor),
              underline: Container(
                height: 2,
                color: AlmaTheme.actionColor,
              ),
              onChanged: (bool? value) => controller.setIscorrect(value!),
              items: controller.optionIsCorrectDrop
                  .map<DropdownMenuItem<bool>>((bool value) {
                return DropdownMenuItem<bool>(
                  value: value,
                  child: AlmaText(text: value ? 'Sim' : 'Não'),
                );
              }).toList(),
            ),
            const Spacer(),
            AlmaButtonWidget(
              onPressed: () {
                controller.addOption();
                _ctrlTexto.clear();
                Navigator.pop(context);
              },
              child: const AlmaText(text: 'Adicionar'),
            )
          ],
        ),
      ),
    );
  }
}
