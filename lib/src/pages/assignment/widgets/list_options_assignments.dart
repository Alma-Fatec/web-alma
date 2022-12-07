import 'package:alma_web/src/controllers/assignment/assignment_controller.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOptionsAssignments extends StatelessWidget {
  const ListOptionsAssignments({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AssignmentController>();
    return ListView.builder(
      itemCount: controller.listOptions.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.question_answer_rounded),
          title: AlmaText(
              text: controller.listOptions[index]['text'],
              fontWeight: FontWeight.bold),
          subtitle: AlmaText(
              text: controller.listOptions[index]['isCorrect']
                  ? 'Alternativa classificada como correta'
                  : 'Alternativa classificada como incorreta',
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
