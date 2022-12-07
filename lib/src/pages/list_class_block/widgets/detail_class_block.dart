import 'package:alma_web/src/data/models/block/block_model.dart';
import 'package:alma_web/src/utils/const.dart';
import 'package:alma_web/src/utils/render_image_web.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:alma_web/src/widgets/detail_pages_structure.dart';
import 'package:flutter/material.dart';

class DetailClassBlock extends StatelessWidget {
  const DetailClassBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final block = ModalRoute.of(context)?.settings.arguments as Block;
    return AlmaPageStructure(
      title: 'ALMA',
      child: DetailPageStructure(
        title: 'Detalhes do bloco de aula',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RenderImageWeb(imageUrl: block.cover ?? Const.unknowImageUrl),
            const SizedBox(height: 20),
            AlmaText(
                text: block.title ?? 'Sem titulo',
                fontSize: 22,
                fontWeight: FontWeight.bold),
            AlmaText(
              text: block.description ?? 'Sem descrição',
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: block.users?.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  leading: const Icon(Icons.school_outlined),
                  title: AlmaText(text: block.users![index]['name'], fontWeight: FontWeight.bold),
                  subtitle: AlmaText(text: block.users?[index]['email'], fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
