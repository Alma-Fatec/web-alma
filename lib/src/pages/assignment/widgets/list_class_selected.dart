import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClassSelected extends StatelessWidget {
  const ListClassSelected({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AssignmentController>();
    return ListView.builder(
      itemCount: controller.listClassAssignment.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.school_outlined),
          title: AlmaText(text: controller.listClassAssignment[index].name!, fontWeight: FontWeight.bold),
          subtitle: AlmaText(text: controller.listClassAssignment[index].description!, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}