import 'package:alma_web/src/controllers/list_class_block/list_class_block_controller.dart';
import 'package:alma_web/src/controllers/list_class_block/list_class_block_state.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClassBlockWidget extends StatelessWidget {
  const ListClassBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ListClassBlockController>();

    if (controller.state == ListClassBlockState.loading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: const Center(
          child: CircularProgressIndicator(
            color: AlmaTheme.primaryColor,
          ),
        ),
      );
    } else if (controller.listClassBlock.isEmpty) {
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
        itemCount: controller.listClassBlock.length,
        itemBuilder: (context, index) => Card(
          color: AlmaTheme.greyAlmaColor,
          child: ListTile(
            title: AlmaText(
              text: controller.listClassBlock[index].title!,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: AlmaText(
              text: controller.listClassBlock[index].description!,
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
                      Routes.detailClassBlock,
                      arguments: controller.listClassBlock[index],
                    ),
                    color: AlmaTheme.actionColor,
                    icon: const Icon(Icons.more_outlined),
                    tooltip: 'Detalhes',
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () => controller.deleteClassBlock(
                      controller.listClassBlock[index].id!,
                      index,
                    ),
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
