import 'package:alma_web/src/controllers/class/class_controller.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListBlockSelected extends StatelessWidget {
  const ListBlockSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClassController>();
    return ListView.builder(
      itemCount: controller.listBlocksClass.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.school_outlined),
          title: AlmaText(text: controller.listBlocksClass[index].title!, fontWeight: FontWeight.bold),
          subtitle: AlmaText(text: controller.listBlocksClass[index].description!, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}