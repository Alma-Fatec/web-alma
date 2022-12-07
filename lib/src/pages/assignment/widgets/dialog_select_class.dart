import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogSelectClass extends StatelessWidget {
  const DialogSelectClass({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AssignmentController>();
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AlmaText(
            text: 'Selecionar aluno',
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
        height: 500,
        width: 500,
        child: ListView.builder(
          itemCount: controller.listClasses.length,
          itemBuilder: (context, index) => ListTile(
            title: AlmaText(text: controller.listClasses[index].name!, fontWeight: FontWeight.bold),
            subtitle: AlmaText(text: controller.listClasses[index].description!, fontWeight: FontWeight.w500),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              controller.addClassOnAssignment(controller.listClasses[index]);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
