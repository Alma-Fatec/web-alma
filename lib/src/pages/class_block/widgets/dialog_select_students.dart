import 'package:alma_web/src/controllers/class_block/class_block_controller.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogSelecStudents extends StatelessWidget {
  const DialogSelecStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClassBlockController>();
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AlmaTextWidget(
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
          itemCount: controller.listAllUsers.length,
          itemBuilder: (context, index) => ListTile(
            title: AlmaTextWidget(text: controller.listAllUsers[index].name!, fontWeight: FontWeight.bold),
            subtitle: AlmaTextWidget(text: controller.listAllUsers[index].email!, fontWeight: FontWeight.w500),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              controller.addUsersAtClassBlock(controller.listAllUsers[index]);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
