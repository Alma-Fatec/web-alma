import 'package:alma_web/src/controllers/list_class/list_class_controller.dart';
import 'package:alma_web/src/controllers/list_class/list_class_state.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClassWidget extends StatelessWidget {
  const ListClassWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ListClassController>();

    if (controller.state == ListClassState.loading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AlmaTheme.primaryColor,
        ),
      );
    } else if (controller.listClasses.isEmpty) {
      return const Center(
        child: AlmaText(
          text: 'Nenhum item encontrado na lista',
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listClasses.length,
        itemBuilder: (context, index) => Card(
          color: AlmaTheme.greyAlmaColor,
          child: ListTile(
            title: AlmaText(
              text: controller.listClasses[index].name!,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: AlmaText(
              text: controller.listClasses[index].description!,
              fontWeight: FontWeight.w600,
            ),
            trailing: SizedBox(
              width: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {},
                    color: AlmaTheme.actionColor,
                    icon: const Icon(Icons.more_outlined),
                    tooltip: 'Detalhes',
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () => controller.deleteClass(controller.listClasses[index].description!, index),
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
