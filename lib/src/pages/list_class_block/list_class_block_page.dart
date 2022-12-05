import 'package:alma_web/src/controllers/list_class_block/list_class_block_controller.dart';
import 'package:alma_web/src/controllers/list_class_block/list_class_block_state.dart';
import 'package:alma_web/src/routes/app_routes.dart';
import 'package:alma_web/src/theme/alma_theme.dart';
import 'package:alma_web/src/utils/snackbar.dart';
import 'package:alma_web/src/widgets/alma_button_widget.dart';
import 'package:alma_web/src/widgets/alma_page_structure.dart';
import 'package:alma_web/src/widgets/alma_text_field.dart';
import 'package:alma_web/src/widgets/alma_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListClassBlockPage extends StatefulWidget {
  const ListClassBlockPage({super.key});

  @override
  State<ListClassBlockPage> createState() => _ListClassBlockPageState();
}

class _ListClassBlockPageState extends State<ListClassBlockPage> {
  late ListClassBlockController controller;

  @override
  void initState() {
    controller = context.read<ListClassBlockController>();

    controller.addListener(() {
      if (controller.state == ListClassBlockState.error) {
        showSnackBar(context, 'Não foi possível carregar a lista de blocos!');
      } else if (controller.state == ListClassBlockState.success) {
        showSnackBar(context, 'Lista carregada com sucesso!', durationMilli: 1000);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlmaPageStructure(
      title: 'ALMA',
      floatingActionButon: FloatingActionButton.extended(
        onPressed: () => controller.refresh(),
        label: const AlmaText(text: 'Recarregar'),
        icon: const Icon(Icons.refresh),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 400,
                child: AlmaTextField(
                  hintText: 'Pesquisar bloco de aula',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              AlmaButtonWidget(
                onPressed: () => Navigator.pushNamed(context, Routes.newBlock),
                iconData: Icons.add_circle_outline,
                color: AlmaTheme.primaryColor,
                width: 220,
                child: const AlmaText(text: 'Criar bloco de aula'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Consumer<ListClassBlockController>(
              builder: (context, value, child) {
                if (value.state == ListClassBlockState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AlmaTheme.primaryColor,
                    ),
                  );
                } else if (value.listClassBlock.isEmpty) {
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
                    itemCount: value.listClassBlock.length,
                    itemBuilder: (context, index) => Card(
                      color: AlmaTheme.greyAlmaColor,
                      child: ListTile(
                        title: AlmaText(
                          text: value.listClassBlock[index].title!,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        subtitle: AlmaText(
                          text: value.listClassBlock[index].description!,
                          fontWeight: FontWeight.w600,
                        ),
                        onTap: () {},
                        trailing: AlmaButtonWidget(
                          onPressed: () => value.deleteClassBlock(
                            value.listClassBlock[index].id!,
                            index,
                          ),
                          height: 40,
                          width: 60,
                          color: AlmaTheme.secondaryColor,
                          child: const Icon(CupertinoIcons.delete),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}