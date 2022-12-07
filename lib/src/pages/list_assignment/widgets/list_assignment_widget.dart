import 'package:alma_web/src/controllers/list_assignment/list_assignment_controller.dart';
import 'package:alma_web/src/controllers/list_assignment/list_assignment_state.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListAssignmentWidget extends StatelessWidget {
  const ListAssignmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ListAssignmentController>();

    if (controller.state == ListAssignmentState.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: const Center(
          child: CircularProgressIndicator(
            color: AlmaTheme.primaryColor,
          ),
        ),
      );
    } else if (controller.listAssignments.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: const Center(
          child: AlmaText(
            text: 'Nenhum item encontrado na lista',
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listAssignments.length,
        itemBuilder: (context, index) => Card(
          color: AlmaTheme.greyAlmaColor,
          child: ListTile(
            title: AlmaText(
              text: controller.listAssignments[index].title!,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: AlmaText(
              text: controller.listAssignments[index].description!,
              fontWeight: FontWeight.w600,
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.detailAssignment,
                      arguments: controller.listAssignments[index],
                    ),
                    color: AlmaTheme.actionColor,
                    icon: const Icon(Icons.more_outlined),
                    tooltip: 'Detalhes',
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () => controller.deleteAssignment(
                        controller.listAssignments[index].id!),
                    color: AlmaTheme.secondaryColor,
                    icon: const Icon(CupertinoIcons.delete),
                    tooltip: 'Apagar',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
