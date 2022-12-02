import 'package:alma_web/src/controllers/list_assignment/list_assignment_controller.dart';
import 'package:alma_web/src/controllers/list_assignment/list_assignment_state.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
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
      return const Center(
        child: CircularProgressIndicator(
          color: AlmaTheme.primaryColor,
        ),
      );
    } else if (controller.listAssignments.isEmpty) {
      return const Center(
        child: AlmaTextWidget(
          text: 'Nenhum item encontrado na lista',
          fontSize: 22,
          fontWeight: FontWeight.w500,
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
            title: AlmaTextWidget(
              text: controller.listAssignments[index].title!,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: AlmaTextWidget(
              text: controller.listAssignments[index].description!,
              fontWeight: FontWeight.w600,
            ),
            onTap: () {},
            trailing: AlmaButtonWidget(
              onPressed: () {},
              height: 40,
              width: 60,
              color: AlmaTheme.secondaryColor,
              child: const Icon(CupertinoIcons.delete),
            ),
          ),
        ),
      );
    }
  }
}
