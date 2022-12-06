import 'package:alma_web/src/data/models/assignment/assignment_model.dart';
import 'package:alma_web/src/utils/const.dart';
import 'package:alma_web/src/utils/render_image_web.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/detail_pages_structure.dart';
import 'package:flutter/material.dart';

class DetailAssignment extends StatelessWidget {
  const DetailAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    final assignment = ModalRoute.of(context)!.settings.arguments as Assignment;
    return AlmaPageStructure(
      title: 'ALMA',
      child: DetailPageStructure(
        title: 'Detalhes da atividade',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenderImageWeb(imageUrl: assignment.cover ?? Const.unknowImageUrl),
            const SizedBox(height: 20),
            AlmaText(
                text: assignment.title ?? 'Sem titulo',
                fontSize: 22,
                fontWeight: FontWeight.bold),
            AlmaText(
              text: assignment.description ?? 'Sem descrição',
              color: Colors.black54,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            AlmaText(
                text: assignment.name ?? 'Sem nome',
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}
