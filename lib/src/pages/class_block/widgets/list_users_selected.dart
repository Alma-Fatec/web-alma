import 'package:alma_web/src/controllers/class_block/class_block_controller.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUserSelected extends StatelessWidget {
  const ListUserSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClassBlockController>();
    return ListView.builder(
      itemCount: controller.listUsersBlock.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.school_outlined),
          title: AlmaText(text: controller.listUsersBlock[index].name!, fontWeight: FontWeight.bold),
          subtitle: AlmaText(text: controller.listUsersBlock[index].email!, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}