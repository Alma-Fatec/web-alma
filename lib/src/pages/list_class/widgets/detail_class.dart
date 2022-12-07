import 'package:alma_web/src/data/models/class/class_model.dart';
import 'package:alma_web/src/utils/const.dart';
import 'package:alma_web/src/utils/render_image_web.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/detail_pages_structure.dart';
import 'package:flutter/material.dart';

class DetailClass extends StatelessWidget {
  const DetailClass({super.key});

  @override
  Widget build(BuildContext context) {
    final classe = ModalRoute.of(context)!.settings.arguments as Class;
    return AlmaPageStructure(
      title: 'ALMA',
      child: DetailPageStructure(
        title: 'Detalhes da aula',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenderImageWeb(imageUrl: classe.cover ?? Const.unknowImageUrl),
            const SizedBox(height: 20),
            AlmaText(
                text: classe.name ?? 'Sem titulo',
                fontSize: 22,
                fontWeight: FontWeight.bold),
            AlmaText(
              text: classe.description ?? 'Sem descrição',
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
